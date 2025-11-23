-module(min_operations).
-export([min_operations/1]).

min_operations(Nums) ->
    K = lists:foldl(fun(X, Acc) -> min(X, Acc) end, hd(Nums), Nums),
    Total = 0,
    lists:foldl(fun(X, Acc) -> Acc + (X - K) end, Total, Nums).