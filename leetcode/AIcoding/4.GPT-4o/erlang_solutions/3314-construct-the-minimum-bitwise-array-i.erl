-module(solution).
-export([construct_minimum_bitwise_array/1]).

construct_minimum_bitwise_array(N) ->
    lists:seq(0, N-1).