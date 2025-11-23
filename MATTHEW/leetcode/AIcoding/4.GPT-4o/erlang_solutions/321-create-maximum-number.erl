-spec max_number(Nums1 :: [integer()], Nums2 :: [integer()], K :: integer()) -> [integer()].

max_number(Nums1, Nums2, K) ->
    max_number_helper(Nums1, Nums2, K, [], []).

max_number_helper(_, [], 0, Acc, _) -> lists:reverse(Acc);
max_number_helper([], _, 0, Acc, _) -> lists:reverse(Acc);
max_number_helper([H1 | T1], [], K, Acc, Nums2) when K > 0 ->
    max_number_helper(T1, Nums2, K - 1, [H1 | Acc], Nums2);
max_number_helper([], [H2 | T2], K, Acc, Nums1) when K > 0 ->
    max_number_helper(Nums1, T2, K - 1, [H2 | Acc], Nums1);
max_number_helper([H1 | T1], [H2 | T2], K, Acc, _) when K > 0 ->
    if
        H1 >= H2 -> max_number_helper(T1, [H2 | T2], K - 1, [H1 | Acc], []);
        true -> max_number_helper([H1 | T1], T2, K - 1, [H2 | Acc], []);
    end.
