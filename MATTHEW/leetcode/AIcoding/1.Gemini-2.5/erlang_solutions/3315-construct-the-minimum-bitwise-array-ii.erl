-module(solution).
-export([construct_minimum_bitwise_array/1]).

construct_minimum_bitwise_array(N) ->
    [ I bxor (I bsr 1) || I <- lists:seq(0, N - 1) ].