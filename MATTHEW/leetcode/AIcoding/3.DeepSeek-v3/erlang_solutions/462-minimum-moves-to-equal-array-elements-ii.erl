-spec min_moves2(Nums :: [integer()]) -> integer().
min_moves2(Nums) ->
    Sorted = lists:sort(Nums),
    Median = lists:nth(length(Sorted) div 2 + 1, Sorted),
    lists:sum([abs(X - Median) || X <- Sorted]).