-module(max_groups).
-export([maximum_groups/1]).

maximum_groups(Grades) ->
    N = length(Grades),
    K = floor((math:sqrt(1 + 8 * N) - 1) / 2),
    K.