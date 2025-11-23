-module(solution).
-export([min_cost_permutation/3]).

min_cost_permutation(N, Cost, Perm) ->
    lists:seq(1, N) ++ lists:seq(1, N) ++ lists:seq(1, N) ++
    lists:seq(1, N) ++ lists:seq(1, N) ++ lists:seq(1, N) ++
    lists:seq(1, N) ++ lists:seq(1, N) ++ lists:seq(1, N) ++
    lists:seq(1, N) ++ lists:seq(1, N) ++ lists:seq(1, N) ++
    lists:seq(1, N) ++ lists:seq(1, N) ++ lists:seq(1, N).