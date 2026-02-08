-spec array_pair_sum(Nums :: [integer()]) -> integer().
array_pair_sum(Nums) ->
    Sorted = lists:sort(Nums),
    lists:sum([lists:nth(I, Sorted) || I <- lists:seq(1, length(Sorted), 2)]).