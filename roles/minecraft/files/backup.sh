#!/bin/bash

function rcon {
  {{ minecraft_home }}/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p {{ lookup('password', '/tmp/rconpasswordfile chars=ascii_letters,digits')}} "$1"
}

rcon "save-off"
rcon "save-all"
tar -cvpzf {{ minecraft_home }}/backups/server-$(date +%F-%H-%M).tar.gz {{ minecraft_home }}/server
rcon "save-on"

## Delete older backups
find {{ minecraft_home }}/backups/ -type f -mtime +7 -name '*.gz' -delete