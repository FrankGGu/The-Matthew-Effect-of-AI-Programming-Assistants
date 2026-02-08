-module(bridge).
-export([cross_bridge/1]).

cross_bridge(times) ->
  cross_bridge(times, 0, []).

cross_bridge([], Time, _) ->
  Time;
cross_bridge([H|T], Time, Acc) ->
  cross_bridge(T, Time + H, Acc ++ [H]).