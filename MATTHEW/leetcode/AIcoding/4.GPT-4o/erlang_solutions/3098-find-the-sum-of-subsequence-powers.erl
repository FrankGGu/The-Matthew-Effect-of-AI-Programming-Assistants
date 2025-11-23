-module(solution).
-export([sum_of_subsequence_powers/1]).

sum_of_subsequence_powers(Numbers) ->
    Mod = 1000000007,
    Total = lists:foldl(fun(X, Acc) ->
        (Acc * 2 + X) rem Mod
    end, 0, Numbers),
    Total.