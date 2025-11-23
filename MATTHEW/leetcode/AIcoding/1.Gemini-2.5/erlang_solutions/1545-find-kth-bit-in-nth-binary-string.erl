-module(solution).
-export([findKthBit/2]).

findKthBit(N, K) ->
    find_kth_bit_recursive(N, K).

find_kth_bit_recursive(1, _K) ->
    '0'.

find_kth_bit_recursive(N, K) ->
    LenNMinus1 = (1 bsl (N-1)) - 1,

    if
        K == LenNMinus1 + 1 ->
            '1';
        K =< LenNMinus1 ->
            find_kth_bit_recursive(N-1, K);
        true ->
            KPrime = K - (LenNMinus1 + 1),
            KDoublePrime = LenNMinus1 - KPrime + 1,
            Bit = find_kth_bit_recursive(N-1, KDoublePrime),
            invert_bit(Bit)
    end.

invert_bit('0') -> '1';
invert_bit('1') -> '0'.