-module(solution).
-export([minOperations/1]).

minOperations(Target) ->
    minOperations(Target, 0, 0).

minOperations([], _, Acc) ->
    Acc;
minOperations([H|T], Prev, Acc) ->
    Diff = H - Prev,
    minOperations(T, H, Acc + Diff).