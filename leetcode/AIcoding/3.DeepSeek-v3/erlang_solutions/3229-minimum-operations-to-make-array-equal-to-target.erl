-module(solution).
-export([min_operations/1]).

min_operations(Target) ->
    lists:sum([X || X <- Target, X > 0]) - length([X || X <- Target, X > 0]).