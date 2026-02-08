-module(solution).
-export([min_operations/1]).

min_operations(N) ->
    (N div 2) * (N div 2) + (N rem 2) * ((N div 2) + 1).