-module(special_array_i).
-export([solve/1]).

solve(Nums) ->
    Count = length(Nums),
    lists:all(fun(X) -> X < Count end, Nums).