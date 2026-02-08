-module(solution).
-export([total_hamming_distance/1]).

total_hamming_distance(Nums) ->
    total_hamming_distance_loop(Nums, 0, 0).

total_hamming_distance_loop(_Nums, 32, Acc) ->
    Acc;
total_hamming_distance_loop(Nums, BitIdx, Acc) ->
    {Count0, Count1} = count_bits(Nums, BitIdx),
    NewAcc = Acc + (Count0 * Count1),
    total_hamming_distance_loop(Nums, BitIdx + 1, NewAcc).

count_bits(Nums, BitIdx) ->
    count_bits_loop(Nums, BitIdx, 0, 0).

count_bits_loop([], _BitIdx, Count0, Count1) ->
    {Count0, Count1};
count_bits_loop([H|T], BitIdx, Count0, Count1) ->
    ShiftedBit = 1 bsl BitIdx,
    if (H band ShiftedBit) == 0 ->
        count_bits_loop(T, BitIdx, Count0 + 1, Count1);
    true ->
        count_bits_loop(T, BitIdx, Count0, Count1 + 1)
    end.