merge(Nums1, M, Nums2, N) ->
    merge_helper(Nums1, M, Nums2, N, M + N - 1).

merge_helper(Nums1, 0, Nums2, N, K) ->
    lists:sublist(Nums2, 1, N) ++ lists:nthtail(N, Nums1);
merge_helper(Nums1, M, Nums2, 0, _K) ->
    Nums1;
merge_helper(Nums1, M, Nums2, N, K) ->
    case lists:nth(M, Nums1) >= lists:nth(N, Nums2) of
        true ->
            NewNums1 = setelement(K + 1, list_to_tuple(Nums1), lists:nth(M, Nums1)),
            merge_helper(tuple_to_list(NewNums1), M - 1, Nums2, N, K - 1);
        false ->
            NewNums1 = setelement(K + 1, list_to_tuple(Nums1), lists:nth(N, Nums2)),
            merge_helper(tuple_to_list(NewNums1), M, Nums2, N - 1, K - 1)
    end.