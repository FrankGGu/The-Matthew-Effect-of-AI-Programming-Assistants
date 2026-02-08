-spec intersection(Nums1 :: [integer()], Nums2 :: [integer()]) -> [integer()].
intersection(Nums1, Nums2) ->
    lists:usort(Nums1 -- lists:subtract(Nums1, Nums2)).
