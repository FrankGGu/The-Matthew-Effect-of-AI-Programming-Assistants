-module(bitwise_xor_of_all_pairings).
-export([bitwise_xor_of_all_pairings/2]).

bitwise_xor_of_all_pairings(Nums1, Nums2) ->
    bitwise_xor_of_all_pairings_helper(Nums1, Nums2, 0).

bitwise_xor_of_all_pairings_helper([], _, Acc) ->
    Acc;
bitwise_xor_of_all_pairings_helper([H|T], Nums2, Acc) ->
    NewAcc = bitwise_xor_of_all_pairings_nums2(H, Nums2, Acc),
    bitwise_xor_of_all_pairings_helper(T, Nums2, NewAcc).

bitwise_xor_of_all_pairings_nums2(_, [], Acc) ->
    Acc;
bitwise_xor_of_all_pairings_nums2(Num1, [H|T], Acc) ->
    NewAcc = Acc bxor (Num1 bxor H),
    bitwise_xor_of_all_pairings_nums2(Num1, T, NewAcc).