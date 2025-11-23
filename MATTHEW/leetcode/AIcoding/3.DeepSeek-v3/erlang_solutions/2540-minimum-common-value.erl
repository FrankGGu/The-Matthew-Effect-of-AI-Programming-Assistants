-spec get_common(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
get_common(Nums1, Nums2) ->
    Set1 = sets:from_list(Nums1),
    Set2 = sets:from_list(Nums2),
    Common = sets:intersection(Set1, Set2),
    case sets:size(Common) of
        0 -> -1;
        _ -> lists:min(sets:to_list(Common))
    end.