-spec maximum_set_size(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
maximum_set_size(Nums1, Nums2) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),
    Common = sets:intersection(Set1, Set2),
    SizeCommon = sets:size(Common),
    Size1 = sets:size(Set1) - SizeCommon,
    Size2 = sets:size(Set2) - SizeCommon,
    MaxRemove = min(Size1, Size2),
    min(SizeCommon, MaxRemove) + Size1 + Size2.