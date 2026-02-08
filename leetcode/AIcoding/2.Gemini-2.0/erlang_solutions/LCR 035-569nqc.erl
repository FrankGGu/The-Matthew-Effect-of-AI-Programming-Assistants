-module(min_time_difference).
-export([find_min_difference/1]).

find_min_difference(TimePoints) ->
    Times = lists:map(fun(TimePoint) ->
                              [H, M] = string:split(TimePoint, ":", all),
                              {list_to_integer(H), list_to_integer(M)}
                      end, TimePoints),
    SortedTimes = lists:sort(Times),
    Diffs = calculate_diffs(SortedTimes),
    lists:min(Diffs).

calculate_diffs([H1, M1] = Time, []) ->
    [time_diff(Time, [H1, M1])];
calculate_diffs([{H1, M1} = Time1, {H2, M2} = Time2 | Rest]) ->
    [time_diff(Time1, Time2) | calculate_diffs([{H2, M2}, {H2, M2} | Rest])];
calculate_diffs([{H1, M1} = Time1]) ->
    [time_diff(Time1, Time1)].

time_diff({H1, M1}, {H2, M2}) ->
    Diff = abs((H1 * 60 + M1) - (H2 * 60 + M2)),
    min(Diff, 1440 - Diff).