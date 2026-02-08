-module(solution).
-export([minimum_difference/2]).

minimum_difference(Scores, K) ->
    Sorted = lists:sort(Scores),
    MinDiff(Sorted, K, 1, infinity).

MinDiff(Sorted, K, Start, Min) when Start + K - 1 =< length(Sorted) ->
    CurrentDiff = lists:nth(Start + K - 1, Sorted) - lists:nth(Start, Sorted),
    NewMin = min(CurrentDiff, Min),
    MinDiff(Sorted, K, Start + 1, NewMin);
MinDiff(_, _, _, Min) ->
    Min.