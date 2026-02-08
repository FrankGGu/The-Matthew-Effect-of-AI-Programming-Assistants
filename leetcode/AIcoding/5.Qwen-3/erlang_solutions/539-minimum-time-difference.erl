-module(minimum_time_difference).
-export([findMinDifference/1]).

findMinDifference(TimePoints) ->
    Sorted = lists:sort([parse_time(T) || T <- TimePoints]),
    Min = lists:min([diff(H, lists:nth(I, Sorted)) || I <- lists:seq(1, length(Sorted)), H <- [lists:last(Sorted)] ++ lists:tl(Sorted)]),
    Min.

parse_time(Time) ->
    [H, M] = string:split(Time, ":"),
    {list_to_integer(H), list_to_integer(M)}.

diff({H1, M1}, {H2, M2}) ->
    T1 = H1 * 60 + M1,
    T2 = H2 * 60 + M2,
    D = abs(T1 - T2),
    min(D, 24 * 60 - D).