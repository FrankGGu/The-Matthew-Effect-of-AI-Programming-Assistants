-module(solution).
-export([max_free_time/1]).

max_free_time(Schedule) ->
    Sorted = lists:sort(Schedule),
    Merged = merge_intervals(Sorted),
    MaxGap = find_max_gap(Merged),
    MaxGap.

merge_intervals(Intervals) ->
    merge_intervals(Intervals, []).

merge_intervals([], Merged) ->
    lists:reverse(Merged);
merge_intervals([Interval | Rest], []) ->
    merge_intervals(Rest, [Interval]);
merge_intervals([ [Start, End] | Rest ], [ [MStart, MEnd] | MergedRest ]) ->
    if
        Start =< MEnd ->
            NewInterval = [MStart, max(End, MEnd)],
            merge_intervals(Rest, [NewInterval | MergedRest]);
        true ->
            merge_intervals(Rest, [ [Start, End], [MStart, MEnd] | MergedRest ])
    end.

find_max_gap(Merged) ->
    find_max_gap(Merged, 0).

find_max_gap([_], Max) ->
    Max;
find_max_gap([ [_, End1], [Start2, _] | Rest ], Max) ->
    Gap = Start2 - End1,
    NewMax = max(Gap, Max),
    find_max_gap([ [Start2, _] | Rest ], NewMax).