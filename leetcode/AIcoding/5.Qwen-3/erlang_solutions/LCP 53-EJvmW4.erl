-module(solution).
-export([min_operations/1]).

min_operations(Nums) ->
    N = length(Nums),
    Count = lists:foldl(fun(X, Acc) -> Acc + X end, 0, Nums),
    if
        Count rem 2 == 0 -> Count div 2;
        true -> -1
    end.