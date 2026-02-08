-module(merge_operations_for_min_travel_time).
-export([min_travel_time/1]).

min_travel_time(Operations) ->
    min_travel_time(Operations, 0).

min_travel_time([], Acc) ->
    Acc;
min_travel_time([{move, X} | T], Acc) ->
    min_travel_time(T, Acc + abs(X));
min_travel_time([{turn, D} | T], Acc) ->
    min_travel_time(T, Acc).