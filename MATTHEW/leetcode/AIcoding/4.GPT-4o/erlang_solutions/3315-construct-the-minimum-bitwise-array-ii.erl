-module(solution).
-export([construct_minimum_bitwise_array/1]).

construct_minimum_bitwise_array(N) when N > 0 ->
    lists:map(fun(X) -> X bxor (N - 1) end, lists:seq(0, N - 1)).