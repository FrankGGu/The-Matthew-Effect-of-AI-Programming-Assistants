-module(solution).
-export([sum_k_set_bits/2]).

sum_k_set_bits(N, K) ->
    lists:sum([Idx || Idx <- lists:seq(0, N-1), count_set_bits(Idx) =:= K]).

count_set_bits(0) -> 0;
count_set_bits(N) -> (N band 1) + count_set_bits(N bsr 1).