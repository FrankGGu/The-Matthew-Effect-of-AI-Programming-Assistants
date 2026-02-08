-module(minimum_time_difference).
-export([findMinDifference/1]).

findMinDifference(TimePoints) ->
    Sorted = lists:sort(TimePoints),
    MinDiff = lists:foldl(fun(T1, Acc) ->
        T2 = lists:nth(2, Sorted),
        Diff = time_diff(T1, T2),
        case Diff of
            0 -> 0;
            _ -> min(Diff, Acc)
        end
    end, 1440, Sorted),
    MinDiff.

time_diff(T1, T2) ->
    {H1, M1} = parse_time(T1),
    {H2, M2} = parse_time(T2),
    Diff = (H2 * 60 + M2) - (H1 * 60 + M1),
    if Diff < 0 -> Diff + 1440; true -> Diff end.

parse_time(Time) ->
    [H, M] = string:split(Time, ":"),
    {list_to_integer(H), list_to_integer(M)}.