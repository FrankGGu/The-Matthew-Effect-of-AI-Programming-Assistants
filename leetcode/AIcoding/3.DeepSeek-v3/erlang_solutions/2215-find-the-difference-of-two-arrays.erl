-spec find_difference(Nums1 :: [integer()], Nums2 :: [integer()]) -> [[integer()]].
find_difference(Nums1, Nums2) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),
    Diff1 = sets:to_list(sets:subtract(Set1, Set2)),
    Diff2 = sets:to_list(sets:subtract(Set2, Set1)),
    [Diff1, Diff2].