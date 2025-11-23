-module(maximum_bags).
-export([maximum_bags/3]).

maximum_bags(Capacity, Rocks, AdditionalRocks) ->
    Bags = lists:zip(Capacity, Rocks),
    Diffs = [C - R || {C, R} <- Bags],
    SortedDiffs = lists:sort(Diffs),
    maximum_bags_helper(SortedDiffs, AdditionalRocks, 0).

maximum_bags_helper([], _, Count) ->
    Count;
maximum_bags_helper([Diff | Rest], AdditionalRocks, Count) when Diff =< AdditionalRocks ->
    maximum_bags_helper(Rest, AdditionalRocks - Diff, Count + 1);
maximum_bags_helper(_, _, Count) ->
    Count.