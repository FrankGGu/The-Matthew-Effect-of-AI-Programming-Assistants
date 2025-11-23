-spec added_integer(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
added_integer(Nums1, Nums2) ->
    Sorted1 = lists:sort(Nums1),
    Sorted2 = lists:sort(Nums2),
    [H1 | _] = Sorted1,
    [H2 | _] = Sorted2,
    H2 - H1.