-module(minimum_time_difference).
-export([find_min_difference/1]).

find_min_difference(TimePoints) ->
    SortedTimes = lists:sort([time_to_minutes(T) || T <- TimePoints]),
    N = length(SortedTimes),
    MinDiff = lists:foldl(
        fun(Time, Acc) ->
            Diff = abs(Time - lists:nth(1, Acc)),
            min(Diff, 1440 - Diff, lists:nth(2, Acc))
        end,
        {hd(SortedTimes), hd(SortedTimes), 1440},
        tl(SortedTimes)
    ),
    LastDiff = abs(lists:last(SortedTimes) - hd(SortedTimes)),
    min(MinDiff, 1440 - LastDiff, LastDiff).

time_to_minutes(Time) ->
    [H, M] = string:tokens(Time, ":"),
    list_to_integer(H) * 60 + list_to_integer(M).