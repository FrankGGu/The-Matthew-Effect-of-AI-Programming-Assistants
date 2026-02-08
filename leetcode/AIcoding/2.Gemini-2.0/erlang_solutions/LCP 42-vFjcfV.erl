-module(toys).
-export([circleBox/1]).

circleBox(radii) ->
  lists:foldl(fun(R, Acc) -> Acc + (R * R)), 0, radii).