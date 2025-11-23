-module(solution).
-export([maximum_sum/1]).

maximum_sum(Nums) ->
    MaxSum = lists:max(lists:map(fun(X) -> almost_unique_sum(X, Nums) end, Nums)),
    MaxSum.

almost_unique_sum(X, Nums) ->
    UniqueList = lists:filter(fun(Y) -> Y =:= X end, Nums),
    lists:sum(UniqueList).