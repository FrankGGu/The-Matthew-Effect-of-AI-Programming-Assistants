-module(solution).
-export([min_one_bit_operations/1]).

min_one_bit_operations(0) -> 0;
min_one_bit_operations(N) when N > 0 ->
    K = trunc(math:log2(N)),
    TwoPowK = 1 bsl K,
    TwoPowKPlus1Minus1 = (1 bsl (K + 1)) - 1,
    TwoPowKPlus1Minus1 - min_one_bit_operations(N - TwoPowK).