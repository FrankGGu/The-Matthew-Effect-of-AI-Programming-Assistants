-module(solution).
-export([min_changes/1]).

min_changes(Nums) ->
    N = length(Nums),
    Min = lists:min(Nums),
    Max = lists:max(Nums),
    MinDiff = lists:foldl(fun(X, Acc) -> Acc + abs(X - Min) end, 0, Nums),
    MaxDiff = lists:foldl(fun(X, Acc) -> Acc + abs(X - Max) end, 0, Nums),
    min(MinDiff, MaxDiff).