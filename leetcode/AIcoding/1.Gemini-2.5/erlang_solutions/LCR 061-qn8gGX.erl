-module(solution).
-export([kSmallestPairs/3]).

kSmallestPairs(Nums1, Nums2, K) ->
    N1_orig = length(Nums1),
    N2_orig = length(Nums2),

    if K =< 0; N1_orig == 0; N2_orig == 0 ->
        [];
    true ->
        {ActualNums1, ActualNums2, N1, N2, Swapped} = 
            if N1_orig =< N2_orig ->
                {Nums1, Nums2, N1_orig, N2_orig, false};
            true ->
                {Nums2, Nums1, N2_orig, N1_orig, true}
            end,

        Nums1Arr = array:from_list(ActualNums1),
        Nums2Arr = array:from_list(ActualNums2),

        PQ = gb_trees:empty(),

        InitialPQ = initialize_pq(0, min(K, N1) - 1, Nums1Arr, Nums2Arr, PQ),

        ResultPairs = extract_k_pairs(K, InitialPQ, Nums1Arr, Nums2Arr, N1, N2, []),

        if Swapped ->
            lists:map(fun({V2, V1}) -> {V1, V2} end, ResultPairs);
        true ->
            ResultPairs
        end
    end.

initialize_pq(I, MaxI, Nums1Arr, Nums2Arr, PQ) when I =< MaxI ->
    Sum = array:get(I, Nums1Arr) + array:get(0, Nums2Arr),
    NewPQ = gb_trees:insert({Sum, I, 0}, {I, 0}, PQ),
    initialize_pq(I + 1, MaxI, Nums1Arr, Nums2Arr, NewPQ);
initialize_pq(_I, _MaxI, _Nums1Arr, _Nums2Arr, PQ) ->
    PQ.

extract_k_pairs(0, _PQ, _Nums1Arr, _Nums2Arr, _N1, _N2, Acc) ->
    lists:reverse(Acc);
extract_k_pairs(K, PQ, Nums1Arr, Nums2Arr, _N1, N2, Acc) ->
    case gb_trees:take_smallest(PQ) of
        error ->
            lists:reverse(Acc);
        {{_Sum, I, J}, {_I_val, _J_val}, NewPQ} ->
            Pair = {array:get(I, Nums1Arr), array:get(J, Nums2Arr)},

            UpdatedPQ = 
                if J + 1 < N2 ->
                    NextSum = array:get(I, Nums1Arr) + array:get(J + 1, Nums2Arr),
                    gb_trees:insert({NextSum, I, J + 1}, {I, J + 1}, NewPQ);
                true ->
                    NewPQ
                end,

            extract_k_pairs(K - 1, UpdatedPQ, Nums1Arr, Nums2Arr, _N1, N2, [Pair | Acc])
    end.