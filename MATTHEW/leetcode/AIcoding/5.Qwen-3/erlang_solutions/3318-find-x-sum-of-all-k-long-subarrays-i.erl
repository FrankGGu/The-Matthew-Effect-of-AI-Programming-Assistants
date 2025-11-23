-module(solution).
-export([k_longest_subarrays/2]).

k_longest_subarrays(Nums, K) ->
    lists:sum([lists:sublist(Nums, I, K) || I <- lists:seq(1, length(Nums) - K + 1)]).

k_longest_subarrays(_Args) ->
    erlang:error(badarg).