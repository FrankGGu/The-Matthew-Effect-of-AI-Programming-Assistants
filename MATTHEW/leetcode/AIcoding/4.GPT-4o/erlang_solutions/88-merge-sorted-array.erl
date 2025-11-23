%% Merge Sorted Array
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec merge_sorted_array(Nums1 :: list(integer()), M :: integer(), Nums2 :: list(integer()), N :: integer()) -> list(integer()).
merge_sorted_array(Nums1, M, Nums2, N) ->
    merge_sorted_array(Nums1, M, Nums2, N, []).

merge_sorted_array([], _, [], _, Acc) -> lists:reverse(Acc);
merge_sorted_array(Nums1, 0, [], _, Acc) -> lists:reverse(Acc) ++ Nums1;
merge_sorted_array([], _, [H | T], N, Acc) -> merge_sorted_array([], 0, T, N - 1, [H | Acc]);
merge_sorted_array([H1 | T1], M, [H2 | T2], N, Acc) when H1 =< H2 ->
    merge_sorted_array(T1, M - 1, [H2 | T2], N, [H1 | Acc]);
merge_sorted_array([H1 | T1], M, [H2 | T2], N, Acc) ->
    merge_sorted_array([H1 | T1], M - 1, T2, N, [H2 | Acc]).
