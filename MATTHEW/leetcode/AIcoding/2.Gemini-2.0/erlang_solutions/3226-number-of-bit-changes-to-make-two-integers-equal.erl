-module(solution).
-export([min_bit_flips/2]).

min_bit_flips(Start, Goal) ->
    Xor = Start bxor Goal,
    count_set_bits(Xor, 0).

count_set_bits(0, Count) ->
    Count;
count_set_bits(N, Count) ->
    count_set_bits(N band (N - 1), Count + 1).