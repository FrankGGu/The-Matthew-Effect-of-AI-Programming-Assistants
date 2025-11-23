-module(solution).
-export([min_bit_flips/2]).

min_bit_flips(X, Y) ->
    BitFlips = bxor(X, Y),
    count_set_bits(BitFlips).

count_set_bits(0) -> 0;
count_set_bits(N) -> (N band 1) + count_set_bits(N bsr 1).