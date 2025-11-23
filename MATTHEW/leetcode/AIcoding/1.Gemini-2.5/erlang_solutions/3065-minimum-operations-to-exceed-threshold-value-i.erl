-module(solution).
-export([min_operations/2]).

min_operations(Nums, K) ->
    LessThanK = lists:filter(fun(X) -> X < K end, Nums),
    length(LessThanK).