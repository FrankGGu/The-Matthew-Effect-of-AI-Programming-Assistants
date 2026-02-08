-module(remove_covered_intervals).
-export([removeCoveredIntervals/1]).

removeCoveredIntervals(Intervals) ->
    SortedIntervals = lists:sort(fun({A1, B1}, {A2, B2}) ->
                                         if A1 < A2 then
                                             true
                                         else if A1 == A2 then
                                             B1 > B2
                                         else
                                             false
                                         end
                                 end, Intervals),
    removeCoveredIntervalsHelper(SortedIntervals, 0, -1, 0).

removeCoveredIntervalsHelper([], _, _, Count) ->
    Count;
removeCoveredIntervalsHelper([{A, B} | Rest], MaxA, MaxB, Count) ->
    if A > MaxA andalso B > MaxB then
        removeCoveredIntervalsHelper(Rest, A, B, Count + 1)
    else if B > MaxB then
        removeCoveredIntervalsHelper(Rest, MaxA, B, Count)
    else
        removeCoveredIntervalsHelper(Rest, MaxA, MaxB, Count)
    end.