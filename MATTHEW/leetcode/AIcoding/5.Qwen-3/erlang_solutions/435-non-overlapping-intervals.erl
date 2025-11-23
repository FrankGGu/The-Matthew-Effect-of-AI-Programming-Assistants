-module(non_overlapping_intervals).
-export([erase_overlap_intervals/1]).

erase_overlap_intervals(Intervals) ->
    Sorted = lists:sort(fun(A, B) -> hd(A) < hd(B) end, Intervals),
    erase_overlap_intervals(Sorted, 0, 0).

erase_overlap_intervals([], _Count, _LastEnd) ->
    _Count;
erase_overlap_intervals([Interval | Rest], Count, LastEnd) ->
    [Start | [End | _]] = Interval,
    if
        Start >= LastEnd ->
            erase_overlap_intervals(Rest, Count + 1, End);
        true ->
            erase_overlap_intervals(Rest, Count, LastEnd)
    end.