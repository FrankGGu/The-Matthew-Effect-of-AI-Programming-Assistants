-module(solution).
-export([findMinimumTimeDifference/1]).

time_to_minutes(TimeStr) ->
    [HStr, MStr] = string:tokens(TimeStr, ":"),
    H = list_to_integer(HStr),
    M = list_to_integer(MStr),
    H * 60 + M.

findMinimumTimeDifference(TimePoints) ->
    MinutesList = lists:map(fun time_to_minutes/1, TimePoints),
    SortedMinutes = lists:sort(MinutesList),

    {_, MinAdjacentDiff} = lists:foldl(
        fun(CurrentMinute, {PrevMinute, AccMinDiff}) ->
            Diff = CurrentMinute - PrevMinute,
            {CurrentMinute, min(AccMinDiff, Diff)}
        end,
        {hd(SortedMinutes), 24 * 60},
        tl(SortedMinutes)
    ),

    WrapAroundDiff = (24 * 60 + hd(SortedMinutes)) - lists:last(SortedMinutes),

    min(MinAdjacentDiff, WrapAroundDiff).