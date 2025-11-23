-module(solution).
-export([maximize_sum_of_squares/2]).

-define(MOD, 1000000007).
-define(MAX_BITS, 30).

maximize_sum_of_squares(Nums, _K) ->
    N = length(Nums),
    BitCounts = count_all_bits(Nums),
    ResultNums = build_final_numbers(BitCounts, N),
    calculate_sum_of_squares(ResultNums).

init_bit_counts() ->
    list_to_tuple(lists:duplicate(?MAX_BITS, 0)).

count_all_bits(Nums) ->
    lists:foldl(fun(Num, AccBitCounts) ->
        count_bits_for_num(Num, 0, AccBitCounts)
    end, init_bit_counts(), Nums).

count_bits_for_num(0, _BitPos, BitCounts) -> BitCounts;
count_bits_for_num(Num, BitPos, BitCounts) when BitPos < ?MAX_BITS ->
    NewBitCounts =
        if (Num band 1) == 1 ->
            element(BitPos + 1, BitCounts) + 1;
        else
            element(BitPos + 1, BitCounts)
        end,
    count_bits_for_num(Num bsr 1, BitPos + 1, setelement(BitPos + 1, BitCounts, NewBitCounts));
count_bits_for_num(_Num, _BitPos, BitCounts) ->
    BitCounts.

build_final_numbers(BitCounts, N) ->
    build_final_numbers_recursive(0, N, BitCounts, []).

build_final_numbers_recursive(I, N, _BitCounts, Acc) when I >= N -> lists:reverse(Acc);
build_final_numbers_recursive(I, N, BitCounts, Acc) ->
    CurrentNum = calculate_num_for_index(I, BitCounts, 0, 0),
    build_final_numbers_recursive(I + 1, N, BitCounts, [CurrentNum | Acc]).

calculate_num_for_index(_I, _BitCounts, BitPos, CurrentVal) when BitPos >= ?MAX_BITS -> CurrentVal;
calculate_num_for_index(I, BitCounts, BitPos, CurrentVal) ->
    Count = element(BitPos + 1, BitCounts),
    NewVal =
        if I < Count ->
            CurrentVal bor (1 bsl BitPos);
        else
            CurrentVal
        end,
    calculate_num_for_index(I, BitCounts, BitPos + 1, NewVal).

calculate_sum_of_squares(ResultNums) ->
    lists:foldl(fun(Num, Sum) ->
        (Sum + (Num * Num) rem ?MOD) rem ?MOD
    end, 0, ResultNums).