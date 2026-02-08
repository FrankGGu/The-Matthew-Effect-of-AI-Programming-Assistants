-spec min_partition_value(Nums :: [integer()]) -> integer().
min_partition_value(Nums) ->
    Sorted = lists:sort(Nums),
    lists:min([abs(lists:nth(I + 1, Sorted) - lists:nth(I, Sorted)) || I <- lists:seq(1, length(Sorted) - 1)]).