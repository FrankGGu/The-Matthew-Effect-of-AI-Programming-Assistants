-module(solution).
-export([min_operations/1]).

min_operations(List) ->
    Unique = lists:usort(List),
    MinOps = length(List) - length(Unique),
    MinOps + length(Unique).