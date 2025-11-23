-module(solution).
-export([k_smallest_pairs/3]).

k_smallest_pairs(Nums1_list, Nums2_list, K) ->
    N1 = length(Nums1_list),
    N2 = length(Nums2_list),

    if K == 0; N1 == 0; N2 == 0 ->
        [];
       true ->
        Nums1 = array:from_list(Nums1_list),
        Nums2 = array:from_list(Nums2_list),

        initial_pq(Nums1, Nums2, N1, N2, K)
    end.

initial_pq(Nums1, Nums2, N1, N2, K) ->
    PQ0 = gb_trees:empty(),

    Limit = min(N1, K),

    PQ1 = add_initial_pairs_to_pq(0, Limit, Nums1, Nums2, N2, PQ0),

    extract_k_pairs(K, Nums1, Nums2, N2, PQ1, []).

add_initial_pairs_to_pq(I, Limit, Nums1, Nums2, N2, PQ_Acc) when I < Limit ->
    Num1_I = array:get(I, Nums1),
    Num2_0 = array:get(0, Nums2),
    Sum = Num1_I + Num2_0,

    PQ_Next = gb_trees:insert({Sum, I, 0}, {I, 0}, PQ_Acc),
    add_initial_pairs_to_pq(I + 1, Limit, Nums1, Nums2, N2, PQ_Next);
add_initial_pairs_to_pq(_I, _Limit, _Nums1, _Nums2, _N2, PQ_Acc) ->
    PQ_Acc.

extract_k_pairs(K, Nums1, Nums2, N2, PQ_Acc, Result_Acc) when K > 0 andalso not gb_trees:is_empty(PQ_Acc) ->
    {{_Sum, I, J}, {_I_val, _J_val}} = gb_trees:smallest(PQ_Acc),
    PQ_Next = gb_trees:delete_smallest(PQ_Acc),

    Num1 = array:get(I, Nums1),
    Num2 = array:get(J, Nums2),

    NewResult_Acc = [[Num1, Num2] | Result_Acc],

    if J + 1 < N2 ->
        Num2_next = array:get(J + 1, Nums2),
        Sum_next = Num1 + Num2_next,
        PQ_Final = gb_trees:insert({Sum_next, I, J + 1}, {I, J + 1}, PQ_Next);
       true ->
        PQ_Final = PQ_Next
    end,

    extract_k_pairs(K - 1, Nums1, Nums2, N2, PQ_Final, NewResult_Acc);
extract_k_pairs(_K, _Nums1, _Nums2, _N2, _PQ_Acc, Result_Acc) ->
    lists:reverse(Result_Acc).