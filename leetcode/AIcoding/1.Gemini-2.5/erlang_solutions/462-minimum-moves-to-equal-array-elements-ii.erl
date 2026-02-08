-spec min_moves(Nums :: [integer()]) -> integer().
min_moves(Nums) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    MedianIndex = Len div 2,
    Median = lists:nth(MedianIndex + 1, SortedNums),
    lists:foldl(fun(Num, Acc) -> Acc + abs(Num - Median) end, 0, SortedNums).