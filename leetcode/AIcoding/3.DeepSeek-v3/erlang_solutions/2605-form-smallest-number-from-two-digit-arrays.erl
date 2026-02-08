-spec min_number(nums1 :: [integer()], nums2 :: [integer()]) -> integer().
min_number(Nums1, Nums2) ->
    Common = sets:intersection(sets:from_list(Nums1), sets:from_list(Nums2)),
    case sets:size(Common) > 0 of
        true -> lists:min(sets:to_list(Common));
        false ->
            Min1 = lists:min(Nums1),
            Min2 = lists:min(Nums2),
            if
                Min1 < Min2 -> Min1 * 10 + Min2;
                true -> Min2 * 10 + Min1
            end
    end.