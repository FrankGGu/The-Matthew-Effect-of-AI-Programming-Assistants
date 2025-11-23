-module(solution).
-export([min_bit_flips/2]).

min_bit_flips(Start, Goal) ->
    Diff = bxor(Start, Goal),
    count_set_bits(Diff).

count_set_bits(0) -> 0;
count_set_bits(N) when N > 0 ->
    1 + count_set_bits(N band (N - 1)).