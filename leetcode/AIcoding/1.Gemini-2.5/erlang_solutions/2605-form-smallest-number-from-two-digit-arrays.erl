-spec form_smallest_number(Nums1 :: [integer()], Nums2 :: [integer()]) -> integer().
form_smallest_number(Nums1, Nums2) ->
    Min1 = lists:min(Nums1),
    Min2 = lists:min(Nums2),

    Common = [D || D <- Nums1, lists:member(D, Nums2)],

    case Common of
        [] ->
            min(Min1 * 10 + Min2, Min2 * 10 + Min1);
        _ ->
            lists:min(Common)
    end.