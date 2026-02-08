-module(solution).
-export([merge_intervals/1]).

merge_intervals(Intervals) ->
    Sorted = lists:sort(fun([S1, _], [S2, _]) -> S1 =< S2 end, Intervals),
    case Sorted of
        [] -> [];
        [[S, E] | Rest] ->
            merge_helper(Rest, [S, E], [])
    end.

merge_helper([], CurrentMerged, Acc) ->
    lists:reverse([CurrentMerged | Acc]).
merge_helper([[NextS, NextE] | Rest], [CurrentS, CurrentE], Acc) ->
    if NextS =< CurrentE ->
        NewCurrentE = max(CurrentE, NextE),
        merge_helper(Rest, [CurrentS, NewCurrentE], Acc);
    else
        merge_helper(Rest, [NextS, NextE], [CurrentS, CurrentE | Acc])
    end.