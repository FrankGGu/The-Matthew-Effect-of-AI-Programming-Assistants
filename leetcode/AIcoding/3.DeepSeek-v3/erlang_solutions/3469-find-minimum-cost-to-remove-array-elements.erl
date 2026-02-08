-module(solution).
-export([minimum_cost/1]).

minimum_cost(Nums) ->
    {Sum, Max} = lists:foldl(fun(N, {S, M}) -> {S + N, max(M, N)} end, {0, 0}, Nums),
    Sum - Max.