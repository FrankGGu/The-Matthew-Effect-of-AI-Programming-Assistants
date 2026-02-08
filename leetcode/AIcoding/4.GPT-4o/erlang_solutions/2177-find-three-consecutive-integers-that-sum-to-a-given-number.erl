-module(solution).
-export([sum_three_consecutive_integers/1]).

sum_three_consecutive_integers(Sum) ->
    X = (Sum - 3) div 3,
    [X + 1, X + 2, X + 3].