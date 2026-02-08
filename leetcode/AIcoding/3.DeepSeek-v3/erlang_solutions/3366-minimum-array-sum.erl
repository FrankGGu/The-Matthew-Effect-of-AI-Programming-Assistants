-spec min_sum(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
min_sum(Nums1, Nums2) ->
    Sorted1 = lists:sort(Nums1),
    Sorted2 = lists:sort(Nums2),
    lists:sum(lists:zipwith(fun(X, Y) -> max(X, Y) end, Sorted1, Sorted2)).