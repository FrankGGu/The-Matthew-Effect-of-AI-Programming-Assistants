-module(solution).
-export([sum_zero/1]).

sum_zero(N) ->
    lists:seq(1, N div 2) ++ lists:seq(-1, -N div 2).