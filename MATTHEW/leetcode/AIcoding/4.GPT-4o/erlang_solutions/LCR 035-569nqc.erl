-module(solution).
-export([find_min_difference/1]).

find_min_difference(TimeSlots) ->
    Times = [time_to_minutes(Time) || Time <- TimeSlots],
    SortedTimes = lists:sort(Times),
    MinDiff = lists:foldl(fun({Prev, Cur}, Acc) -> min(Acc, Cur - Prev) end, hd(SortedTimes) + 1440 - last(SortedTimes), zip(SortedTimes)),
    MinDiff.

time_to_minutes(Time) ->
    [H | M] = string:tokens(Time, ":"),
    list_to_integer(H) * 60 + list_to_integer(hd(M)).

zip([]) -> [];
zip([H|T]) -> [{H, hd(T)} | zip(T)].