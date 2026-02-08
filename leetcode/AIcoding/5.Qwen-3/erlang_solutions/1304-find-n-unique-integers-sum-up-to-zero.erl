-module(solution).
-export([find_unique_integers_sum_to_zero/1]).

find_unique_integers_sum_to_zero(N) ->
    lists:seq(1, N-1) ++ [-sum(lists:seq(1, N-1))].