-spec count_bad_pairs(Nums :: [integer()]) -> integer().
count_bad_pairs(Nums) ->
    Total = length(Nums),
    TotalPairs = Total * (Total - 1) div 2,
    GoodPairs = count_good_pairs(Nums, 0, #{}),
    TotalPairs - GoodPairs.

count_good_pairs([], _, Map) ->
    0;
count_good_pairs([Num | Rest], Index, Map) ->
    Key = Num - Index,
    Count = maps:get(Key, Map, 0),
    NewMap = maps:put(Key, Count + 1, Map),
    Count + count_good_pairs(Rest, Index + 1, NewMap).