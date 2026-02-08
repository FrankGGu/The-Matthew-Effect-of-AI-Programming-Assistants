-module(solution).
-export([minOperations/2]).

minOperations(Nums, K) ->
    lists:foldl(fun(Num, Acc) ->
                    Acc + abs(Num - K)
                end, 0, Nums).