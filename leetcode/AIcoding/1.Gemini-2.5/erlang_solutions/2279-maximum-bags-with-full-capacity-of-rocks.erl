-module(solution).
-export([maximumBags/3]).

maximumBags(Capacity, Rocks, AdditionalRocks) ->
    RemainingCapacities = lists:map(fun({C, R}) -> C - R end, lists:zip(Capacity, Rocks)),
    SortedRemaining = lists:sort(RemainingCapacities),

    fill_bags(SortedRemaining, AdditionalRocks, 0).

fill_bags([], _AdditionalRocks, FullBagsCount) ->
    FullBagsCount;
fill_bags([Needed | Rest], AdditionalRocks, FullBagsCount) ->
    if
        AdditionalRocks >= Needed ->
            fill_bags(Rest, AdditionalRocks - Needed, FullBagsCount + 1);
        true ->
            FullBagsCount
    end.