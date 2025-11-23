-module(solution).
-export([min_increments/1]).

min_increments(Target) ->
    min_increments(Target, 0, 0).

min_increments([], _, Acc) ->
    Acc;
min_increments([H | T], Prev, Acc) ->
    Diff = H - Prev,
    min_increments(T, H, Acc + Diff).