-module(solution).
-export([min_operations/1]).

min_operations(N) ->
    N_sq = N * N,
    if
        N rem 2 == 0 ->
            N_sq div 4;
        true ->
            (N_sq - 1) div 4
    end.