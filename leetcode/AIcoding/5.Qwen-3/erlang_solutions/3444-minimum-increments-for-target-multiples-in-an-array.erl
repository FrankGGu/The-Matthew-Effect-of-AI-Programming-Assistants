-module(solution).
-export([min_increments/2]).

min_increments(Array, Target) ->
    min_increments(Array, Target, 0).

min_increments([], _, Acc) ->
    Acc;
min_increments([H | T], Target, Acc) ->
    Need = Target - H,
    if
        Need < 0 -> min_increments(T, Target, Acc);
        true -> min_increments(T, Target, Acc + Need)
    end.