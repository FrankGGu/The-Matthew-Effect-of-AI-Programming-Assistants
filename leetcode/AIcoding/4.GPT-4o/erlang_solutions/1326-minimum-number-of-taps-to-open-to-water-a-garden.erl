-module(solution).
-export([min_taps/1]).

min_taps(N) ->
    Intervals = lists:map(fun(X) -> {max(0, X - 1), min(N, X + 1)} end, lists:seq(0, N)),
    SortedIntervals = lists:sort(fun({L1, _}, {L2, _}) -> L1 < L2 end, Intervals),
    min_taps_helper(SortedIntervals, 0, N, 0).

min_taps_helper([], _, _, _) -> -1;
min_taps_helper(Intervals, Start, End, Count) ->
    case lists:foldl(fun({L, R}, Acc) ->
                        if
                            L > Acc -> Acc;
                            true -> lists:max([Acc, R])
                        end
                    end, Start, Intervals) of
        NewEnd when NewEnd >= End -> Count + 1;
        NewEnd when NewEnd =< Start -> -1;
        NewEnd -> min_taps_helper(Intervals, NewEnd, End, Count + 1)
    end.