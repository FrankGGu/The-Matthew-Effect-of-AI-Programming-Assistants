-module(hamming_distance).
-export([hamming_distance/2]).

hamming_distance(X, Y) ->
    hamming_distance(X bxor Y, 0).

hamming_distance(0, Count) ->
    Count;
hamming_distance(N, Count) ->
    hamming_distance(N bsr 1, Count + (N band 1)).