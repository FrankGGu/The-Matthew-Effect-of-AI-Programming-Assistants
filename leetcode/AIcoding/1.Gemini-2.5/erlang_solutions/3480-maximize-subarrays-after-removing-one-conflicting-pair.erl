-module(solution).
-export([maximize_subarrays_after_removing_one_conflicting_pair/1]).

remove_nth(List, Nth) ->
    {Before, [_|After]} = lists:split(Nth, List),
    Before ++ After.

count_non_overlapping_sorted(SortedIntervals) ->
    count_non_overlapping_impl(SortedIntervals, 0, -1). %% -1 as initial last_end_time (assuming non-negative times)

count_non_overlapping_impl([], Count, _LastEndTime) ->
    Count;
count_non_overlapping_impl([{Start, End} | Rest], Count, LastEndTime) ->
    if Start >= LastEndTime ->
        count_non_overlapping_impl(Rest, Count + 1, End);
    true ->
        count_non_overlapping_impl(Rest, Count, LastEndTime)
    end.

maximize_subarrays_after_removing_one_conflicting_pair(Intervals) ->
    % Sort intervals once by end time, then by start time for ties
    SortedIntervals = lists:sort(fun({_S1, E1}, {_S2, E2}) ->
                                     E1 < E2 orelse (E1 == E2 andalso _S1 < _S2)
                                 end, Intervals),

    N = length(SortedIntervals),

    % Case 1: Don't remove any interval
    MaxCount = count_non_overlapping_sorted(SortedIntervals),

    % Case 2: Remove one interval
    % Iterate through each interval by its 0-indexed position (K)
    % Calculate max non-overlapping for the list with K-th interval removed.
    % Initialize MaxCountAfterRemoval with MaxCount (the case of removing 0 intervals)
    MaxCountAfterRemoval = lists:foldl(fun(K, AccMax) ->
                                           IntervalsWithoutK = remove_nth(SortedIntervals, K),
                                           CurrentCount = count_non_overlapping_sorted(IntervalsWithoutK),
                                           max(AccMax, CurrentCount)
                                       end, MaxCount, lists:seq(0, N-1)),

    MaxCountAfterRemoval.