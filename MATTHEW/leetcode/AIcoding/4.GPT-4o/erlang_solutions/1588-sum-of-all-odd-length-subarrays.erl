-module(solution).
-export([sum_odd_length_subarrays/1]).

sum_odd_length_subarrays(List) ->
    N = length(List),
    lists:sum(
        [lists:sum(lists:nthtail(I, List)) || I <- lists:seq(0, N-1), J <- lists:seq(1, N, 2), J + I =< N]
    ).