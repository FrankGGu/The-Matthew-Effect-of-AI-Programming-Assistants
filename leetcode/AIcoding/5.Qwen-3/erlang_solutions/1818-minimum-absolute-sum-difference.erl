-module(minimum_absolute_sum_difference).
-export([minAbsoluteSumDiff/2]).

minAbsoluteSumDiff(A, B) ->
    N = length(A),
    SortedA = lists:sort(A),
    min_abs_sum_diff(N, A, B, SortedA, 0, 0).

min_abs_sum_diff(N, A, B, SortedA, I, Min) when I < N ->
    Val = lists:nth(I + 1, B),
    {MinVal, _} = findClosest(SortedA, Val),
    CurrentDiff = abs(lists:nth(I + 1, A) - Val),
    NewMin = min(Min, CurrentDiff + MinVal),
    min_abs_sum_diff(N, A, B, SortedA, I + 1, NewMin);
min_abs_sum_diff(_, _, _, _, _, Min) ->
    Min.

findClosest([], _) -> {infinity, 0};
findClosest([H | T], Target) ->
    if
        H == Target -> {0, H};
        H < Target -> 
            {Diff, Closest} = findClosest(T, Target),
            {abs(H - Target), H};
        true ->
            {abs(H - Target), H}
    end.