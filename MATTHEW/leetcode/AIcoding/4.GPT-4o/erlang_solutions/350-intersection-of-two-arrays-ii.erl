-spec intersect(Nums1 :: [integer()], Nums2 :: [integer()]) -> [integer()].
intersect(Nums1, Nums2) ->
    intersect(Nums1, Nums2, []).

intersect([], _, Acc) -> lists:reverse(Acc);
intersect([H | T], Nums2, Acc) ->
    case lists:member(H, Nums2) of
        true -> intersect(T, lists:delete(H, Nums2), [H | Acc]);
        false -> intersect(T, Nums2, Acc)
    end.
