-module(solution).
-export([construct_arrangement/1]).

construct_arrangement(N) -> 
    lists:seq(1, N) ++ lists:seq(N, 1, -1).