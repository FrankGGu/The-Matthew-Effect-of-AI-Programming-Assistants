-spec max_product(Nums :: [integer()]) -> integer().
max_product(Nums) ->
    Max = lists:nth(1, Nums),
    Min = lists:nth(1, Nums),
    Result = lists:nth(1, Nums),
    max_product(Nums, 2, Max, Min, Result).

max_product([], _Index, _Max, _Min, Result) ->
    Result;
max_product([H | T], Index, Max, Min, Result) ->
    CurrentMax = max(H, max(Max * H, Min * H)),
    CurrentMin = min(H, min(Max * H, Min * H)),
    NewResult = max(Result, CurrentMax),
    max_product(T, Index + 1, CurrentMax, CurrentMin, NewResult).