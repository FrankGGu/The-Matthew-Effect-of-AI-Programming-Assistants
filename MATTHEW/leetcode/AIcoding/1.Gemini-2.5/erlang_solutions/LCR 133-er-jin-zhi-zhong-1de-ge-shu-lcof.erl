-module(solution).
-export([hammingWeight/1]).

hammingWeight(N) ->
    count_bits(N, 0).

count_bits(0, Count) ->
    Count;
count_bits(N, Count) ->
    count_bits(N band (N - 1), Count + 1).