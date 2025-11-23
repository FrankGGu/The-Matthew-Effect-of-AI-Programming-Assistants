-spec max_product_difference(Nums :: [integer()]) -> integer().
max_product_difference(Nums) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    Min1 = hd(SortedNums),
    Min2 = lists:nth(2, SortedNums),
    Max1 = lists:nth(Len - 1, SortedNums),
    Max2 = lists:nth(Len, SortedNums),
    (Max1 * Max2) - (Min1 * Min2).