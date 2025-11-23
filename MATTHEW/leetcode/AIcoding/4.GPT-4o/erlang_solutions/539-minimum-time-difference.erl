-module(solution).
-export([find_min_difference/1]).

-spec find_min_difference([unicode:unicode_binary()]) -> integer().
find_min_difference(TimePoints) ->
    Minutes = lists:map(fun(Time) -> time_to_minutes(Time) end, TimePoints),
    SortedMinutes = lists:sort(Minutes),
    find_min(SortedMinutes, length(SortedMinutes)).

-spec time_to_minutes(unicode:unicode_binary()) -> integer().
time_to_minutes(Time) ->
    [H, M] = string:split(Time, ":"),
    (list_to_integer(H) * 60) + list_to_integer(M).

-spec find_min([integer()], integer()) -> integer().
find_min([_], _) -> 1440; % the maximum difference in minutes (23:59 - 00:00)
find_min([Prev, Next | Rest], Length) ->
    Diff = Next - Prev,
    MinDiff = find_min(Rest, Length),
    min(Diff, MinDiff);
find_min([Prev, Next], Length) -> Next - Prev.

