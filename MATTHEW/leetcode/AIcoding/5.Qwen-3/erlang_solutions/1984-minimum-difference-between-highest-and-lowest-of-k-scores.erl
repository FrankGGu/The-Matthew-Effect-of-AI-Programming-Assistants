-module(minimum_difference).
-export([minimumDifference/1]).

minimumDifference(Scores) ->
    K = 2,
    Sorted = lists:sort(Scores),
    find_min(Sorted, K).

find_min(Sorted, K) ->
    find_min(Sorted, K, 0, lists:nth(K, Sorted) - lists:nth(1, Sorted)).

find_min(_, _, I, Min) when I + K > length(Sorted) ->
    Min;
find_min(Sorted, K, I, Min) ->
    Current = lists:nth(I + K, Sorted) - lists:nth(I + 1, Sorted),
    NewMin = min(Min, Current),
    find_min(Sorted, K, I + 1, NewMin).