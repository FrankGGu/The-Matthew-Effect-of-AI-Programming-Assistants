-module(solution).
-export([findMinDifference/1]).

findMinDifference(TimePoints) ->
    MinutesList = lists:map(fun to_minutes/1, TimePoints),
    SortedMinutes = lists:sort(MinutesList),

    MinAdjacentDiff = calculate_min_adjacent_diff(SortedMinutes, 1440),

    FirstMinute = hd(SortedMinutes),
    LastMinute = lists:last(SortedMinutes),
    WrapAroundDiff = FirstMinute + 1440 - LastMinute,

    min(MinAdjacentDiff, WrapAroundDiff).

to_minutes(TimeStr) ->
    [HH_Str, MM_Str] = string:split(TimeStr, ":", all),
    HH = list_to_integer(HH_Str),
    MM = list_to_integer(MM_Str),
    HH * 60 + MM.

calculate_min_adjacent_diff([_], Acc) ->
    Acc;
calculate_min_adjacent_diff([T1, T2 | Rest], Acc) ->
    Diff = T2 - T1,
    NewAcc = min(Acc, Diff),
    calculate_min_adjacent_diff([T2 | Rest], NewAcc).