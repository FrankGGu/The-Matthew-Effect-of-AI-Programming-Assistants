-spec two_out_of_three(Nums1 :: [integer()], Nums2 :: [integer()], Nums3 :: [integer()]) -> [integer()].
two_out_of_three(Nums1, Nums2, Nums3) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),
    Set3 = sets:from_list(Nums3),

    Intersection12 = sets:intersection(Set1, Set2),
    Intersection13 = sets:intersection(Set1, Set3),
    Intersection23 = sets:intersection(Set2, Set3),

    Union = sets:union(Intersection12, sets:union(Intersection13, Intersection23)),
    sets:to_list(Union).