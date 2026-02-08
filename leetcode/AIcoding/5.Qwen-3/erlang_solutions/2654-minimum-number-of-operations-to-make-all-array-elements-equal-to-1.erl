-module(solution).
-export([min_operations/1]).

min_operations(Nums) ->
    Count = lists:foldl(fun(X, Acc) -> Acc + (if X == 1 -> 0; true -> 1 end) end, 0, Nums),
    if
        Count == 0 -> 0;
        true -> Count - 1 + lists:foldl(fun(X, Acc) -> Acc + (if X == 1 -> 0; true -> 1 end) end, 0, Nums)
    end.