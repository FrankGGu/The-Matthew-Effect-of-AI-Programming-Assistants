-spec k_smallest_pairs(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> [[integer()]].
k_smallest_pairs(Nums1, Nums2, K) ->
    k_smallest_pairs(Nums1, Nums2, K, []).

k_smallest_pairs(_, _, 0, Acc) -> lists:reverse(Acc);
k_smallest_pairs([], _, _, Acc) -> lists:reverse(Acc);
k_smallest_pairs(_, [], _, Acc) -> lists:reverse(Acc);
k_smallest_pairs([H1 | T1], [H2 | T2], K, Acc) ->
    k_smallest_pairs(T1, T2, K - 1, [[H1, H2] | Acc]);
k_smallest_pairs([H1 | T1], [H2 | T2], K, Acc) when K > 0 ->
    k_smallest_pairs(T1, [H2 | T2], K - 1, Acc).
