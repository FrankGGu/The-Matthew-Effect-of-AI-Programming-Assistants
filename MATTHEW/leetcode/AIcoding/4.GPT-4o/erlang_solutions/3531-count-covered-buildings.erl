-module(solution).
-export([count_covered_buildings/1]).

count_covered_buildings(Buildings) ->
    BuildingsSorted = lists:sort(fun({L1, _}, {L2, _}) -> L1 < L2 end, Buildings),
    count_covered(BuildingsSorted, 0, {0, 0}).

count_covered([], Count, _) -> Count;
count_covered([{L, R} | Rest], Count, {LastEnd, LastCount}) ->
    NewCount = if 
        L > LastEnd -> Count + (LastEnd - LastCount) + (R - L);
        true -> Count + (R - LastEnd)
    end,
    count_covered(Rest, NewCount, {max(LastEnd, R), R}).