-module(solution).
-export([max_groups/1]).

max_groups(Donuts) ->
    max_groups(Donuts, 1, 0).

max_groups(Donuts, GroupSize, TotalGroups) when Donuts >= GroupSize ->
    max_groups(Donuts - GroupSize, GroupSize + 1, TotalGroups + 1);
max_groups(_, _, TotalGroups) ->
    TotalGroups.