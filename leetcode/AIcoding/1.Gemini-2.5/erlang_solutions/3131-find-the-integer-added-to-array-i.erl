-spec find_the_integer(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
find_the_integer(Nums1, Nums2) ->
    hd(Nums2) - hd(Nums1).