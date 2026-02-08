-module(solution).
-export([countDays/2]).

countDays(Days, Meetings) ->
    SortedMeetings = lists:sort(Meetings),
    MergedMeetings = merge_intervals(SortedMeetings),
    TotalMeetingDays = calculate_total_days(MergedMeetings),
    Days - TotalMeetingDays.

merge_intervals([]) ->
    [];
merge_intervals([H | T]) ->
    merge_intervals(T, H, []).

merge_intervals([], CurrentInterval, Acc) ->
    lists:reverse([CurrentInterval | Acc]);
merge_intervals([[NextStart, NextEnd] | T], [CurrentStart, CurrentEnd], Acc) ->
    if
        NextStart =< CurrentEnd + 1 ->
            NewCurrentInterval = [CurrentStart, max(CurrentEnd, NextEnd)],
            merge_intervals(T, NewCurrentInterval, Acc);
        true ->
            merge_intervals(T, [NextStart, NextEnd], [[CurrentStart, CurrentEnd] | Acc])
    end.

calculate_total_days([]) ->
    0;
calculate_total_days([[Start, End] | T]) ->
    (End - Start + 1) + calculate_total_days(T).