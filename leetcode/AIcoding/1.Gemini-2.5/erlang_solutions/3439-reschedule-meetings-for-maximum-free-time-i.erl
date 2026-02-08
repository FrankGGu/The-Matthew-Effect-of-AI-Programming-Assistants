-module(solution).
-export([max_free_time/1]).

-define(MAX_TIME, 24 * 60).

max_free_time(Meetings) ->
    %% 1. Sort meetings by their start time.
    SortedMeetings = lists:sort(fun({S1, _}, {S2, _}) -> S1 =< S2 end, Meetings),

    %% 2. Merge overlapping or adjacent meetings into consolidated intervals.
    ConsolidatedIntervals = merge_intervals(SortedMeetings),

    %% 3. Find the largest gap between these consolidated intervals,
    %%    including gaps from the start of the day (0) to the first meeting,
    %%    and from the last meeting to the end of the day (MAX_TIME).
    find_max_gap(ConsolidatedIntervals, ?MAX_TIME).

merge_intervals([]) -> [];
merge_intervals([H | T]) ->
    merge_intervals_acc(T, [H]).

merge_intervals_acc([], Acc) ->
    lists:reverse(Acc);
merge_intervals_acc([{Start, End} | T], [{PrevStart, PrevEnd} | AccT]) when Start =< PrevEnd ->
    %% Current interval overlaps or is adjacent to the last consolidated interval.
    %% Merge them by extending the end of the last consolidated interval.
    merge_intervals_acc(T, [{PrevStart, max(End, PrevEnd)} | AccT]);
merge_intervals_acc([H | T], Acc) ->
    %% Current interval does not overlap with the last consolidated interval.
    %% Add it as a new consolidated interval.
    merge_intervals_acc(T, [H | Acc]).

find_max_gap(ConsolidatedIntervals, MaxTime) ->
    %% Initialize max_gap to 0 and LastEnd to 0 (representing the start of the day).
    find_max_gap_acc(ConsolidatedIntervals, MaxTime, 0, 0).

find_max_gap_acc([], MaxTime, CurrentMaxGap, LastEnd) ->
    %% After processing all intervals, consider the gap from the last interval's end to MaxTime.
    max(CurrentMaxGap, MaxTime - LastEnd);
find_max_gap_acc([{Start, End} | T], MaxTime, CurrentMaxGap, LastEnd) ->
    %% Calculate the gap between the current interval's start and the previous interval's end (or start of day).
    Gap = Start - LastEnd,
    NewMaxGap = max(CurrentMaxGap, Gap),
    %% Continue with the rest of the intervals, updating CurrentMaxGap and LastEnd.
    find_max_gap_acc(T, MaxTime, NewMaxGap, End).