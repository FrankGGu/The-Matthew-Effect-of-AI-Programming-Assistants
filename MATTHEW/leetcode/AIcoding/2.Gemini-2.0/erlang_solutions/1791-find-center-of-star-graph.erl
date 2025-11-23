-module(star_graph).
-export([find_center/1]).

find_center([[V1, V2] | _]) ->
  [[V3, _] | _] = tl([[V1, V2] | _]),
  if V1 == V3 -> V1
  else V2
  end.