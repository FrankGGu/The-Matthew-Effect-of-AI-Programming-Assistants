-module(solution).
-export([maximum_bags/3]).

maximum_bags(Capacities, Rocks, AdditionalRocks) ->
    Lists = lists:zip(Capacities, Rocks),
    Sorted = lists:sort(fun({C1, R1}, {C2, R2}) -> (C1 - R1) < (C2 - R2) end, Lists),
    maximum_bags_helper(Sorted, AdditionalRocks, 0, 0).

maximum_bags_helper([], _, Count, _) -> Count;
maximum_bags_helper([{C, R} | T], AdditionalRocks, Count, UsedRocks) ->
    Needed = C - R,
    if
        Needed =< 0 ->
            maximum_bags_helper(T, AdditionalRocks, Count + 1, UsedRocks);
        Needed =< AdditionalRocks - UsedRocks ->
            maximum_bags_helper(T, AdditionalRocks, Count + 1, UsedRocks + Needed);
        true ->
            maximum_bags_helper(T, AdditionalRocks, Count, UsedRocks)
    end.