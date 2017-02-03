#!/bin/bash
network=traefik-net
if [ ! "$(docker network ls --filter name=$network -q)" ];then
  docker network create --driver=overlay --attachable $network
fi

if [ ! "$(docker service ls --filter name=whoami -q)" ];then
  docker service create \
    --name whoami \
    --label traefik.port=80 \
    --network $network \
      emilevauge/whoami
fi
