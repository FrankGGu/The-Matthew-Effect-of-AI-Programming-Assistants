-module(minimum_bit_flips).
-export([minBitFlips/2]).

minBitFlips(Start, Target) ->
    count_flips(Start bxor Target, 0).

count_flips(0, Count) ->
    Count;
count_flips(N, Count) ->
    count_flips(N bsr 1, Count + (N band 1)).