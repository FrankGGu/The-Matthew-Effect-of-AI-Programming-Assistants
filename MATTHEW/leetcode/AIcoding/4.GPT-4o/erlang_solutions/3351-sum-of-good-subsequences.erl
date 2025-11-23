-module(solution).
-export([sum_of_good_subsequences/1]).

sum_of_good_subsequences(N) ->
    lists:foldl(fun(X, Acc) ->
        Acc + (X * (2 * Acc + 1))
    end, 0, N).