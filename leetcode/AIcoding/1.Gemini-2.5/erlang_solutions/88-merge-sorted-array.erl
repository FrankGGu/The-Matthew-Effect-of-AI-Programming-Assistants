-module(solution).
-export([merge/4]).

merge(Nums1, M, Nums2, N) ->
    ActualNums1 = lists:sublist(Nums1, M),
    merge_sorted_lists(ActualNums1, Nums2).

merge_sorted_lists(L1, []) -> L1;
merge_sorted_lists([], L2) -> L2;
merge_sorted_lists([H1|T1], [H2|T2]) when H1 =< H2 ->
    [H1 | merge_sorted_lists(T1, [H2|T2])];
merge_sorted_lists([H1|T1], [H2|T2]) when H2 < H1 ->
    [H2 | merge_sorted_lists([H1|T1], T2)].