-spec find_max_consecutive_ones(Nums :: [integer()]) -> integer().
find_max_consecutive_ones(Nums) ->
    find_max_consecutive_ones(Nums, 0, 0).

find_max_consecutive_ones([], CurrentMax, GlobalMax) ->
    max(CurrentMax, GlobalMax);
find_max_consecutive_ones([1 | Rest], CurrentMax, GlobalMax) ->
    find_max_consecutive_ones(Rest, CurrentMax + 1, GlobalMax);
find_max_consecutive_ones([_ | Rest], CurrentMax, GlobalMax) ->
    find_max_consecutive_ones(Rest, 0, max(CurrentMax, GlobalMax)).