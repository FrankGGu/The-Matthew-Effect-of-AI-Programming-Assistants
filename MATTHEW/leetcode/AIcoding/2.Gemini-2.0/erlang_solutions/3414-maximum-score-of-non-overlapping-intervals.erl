-module(max_score_intervals).
-export([max_non_overlapping_intervals/1]).

max_non_overlapping_intervals(Intervals) ->
    SortedIntervals = lists:keysort(2, Intervals),
    max_non_overlapping_intervals_helper(SortedIntervals, []).

max_non_overlapping_intervals_helper([], Acc) ->
    lists:sum(Acc);
max_non_overlapping_intervals_helper([Interval | Rest], Acc) ->
    case Acc of
        [] ->
            max_non_overlapping_intervals_helper(Rest, [element(3, Interval)]);
        _ ->
            LastEndTime = lists:last(Acc),
            case element(1, Interval) >= LastEndTime of
                true ->
                    max_non_overlapping_intervals_helper(Rest, Acc ++ [element(3, Interval)]);
                false ->
                    max_non_overlapping_intervals_helper(Rest, Acc)
            end
    end.