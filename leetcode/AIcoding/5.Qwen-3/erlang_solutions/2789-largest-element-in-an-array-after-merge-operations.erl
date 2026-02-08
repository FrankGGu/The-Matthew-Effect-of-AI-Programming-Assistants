-module(solution).
-export([max_after_operations/1]).

max_after_operations(Nums) ->
    lists:foldl(fun(X, Acc) -> max(X, Acc) end, -infinity, Nums).