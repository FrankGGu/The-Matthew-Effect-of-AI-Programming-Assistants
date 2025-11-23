-module(hamming_distance).
-export([hammingDistance/2]).

hammingDistance(X, Y) ->
    hammingDistance_aux(X bxor Y, 0).

hammingDistance_aux(0, Count) ->
    Count;
hammingDistance_aux(N, Count) ->
    hammingDistance_aux(N band (N - 1), Count + 1).