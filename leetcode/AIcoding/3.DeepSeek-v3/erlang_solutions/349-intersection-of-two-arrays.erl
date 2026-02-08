-spec intersection(Nums1 :: [integer()], Nums2 :: [integer()]) -> [integer()].
intersection(Nums1, Nums2) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),
    sets:to_list(sets:intersection(Set1, Set2)).