-module(solution).
-export([min_operations/1]).

min_operations(Array) ->
    lists:sum(Array) div length(Array).