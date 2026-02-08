-module(solution).
-export([minimize_or/1]).

minimize_or(List) ->
    minimize_or(List, 0).

minimize_or([], Acc) ->
    Acc;
minimize_or([H|T], Acc) ->
    NewAcc = Acc bor H,
    minimize_or(T, NewAcc).