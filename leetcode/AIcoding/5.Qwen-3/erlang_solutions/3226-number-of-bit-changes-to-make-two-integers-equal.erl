-module(solution).
-export([hamming_distance/2]).

hamming_distance(A, B) ->
    count_ones(A bxor B).

count_ones(0) ->
    0;
count_ones(N) ->
    (N band 1) + count_ones(N bsr 1).