-spec minimize_max_pair_sum(nums :: [integer()]) -> integer().
minimize_max_pair_sum(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    lists:max([lists:nth(I, Sorted) + lists:nth(Len - I + 1, Sorted) || I <- lists:seq(1, Len div 2)]).