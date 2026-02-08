-module(solution).
-export([minimumCost/2]).

minimumCost(S, cost) ->
    lists:foldl(fun(Char, Acc) ->
        CharCost = lists:nth(Char - $a + 1, cost),
        Acc + CharCost
    end, 0, S).