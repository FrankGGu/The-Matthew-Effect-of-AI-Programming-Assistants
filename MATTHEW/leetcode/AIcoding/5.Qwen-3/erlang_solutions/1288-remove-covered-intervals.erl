-module(remove_covered_intervals).
-export([remove_covered_intervals/1]).

remove_covered_intervals(Intervals) ->
    Sorted = lists:sort(fun(A, B) -> 
        if 
            hd(A) < hd(B) -> true;
            hd(A) == hd(B) -> tl(A) > tl(B);
            true -> false
        end
    end, Intervals),
    remove_covered_intervals(Sorted, []).

remove_covered_intervals([], Result) ->
    lists:reverse(Result);
remove_covered_intervals([Interval | Rest], Result) ->
    case Result of
        [] ->
            remove_covered_intervals(Rest, [Interval | Result]);
        [Last | _] ->
            if 
                tl(Interval) =< tl(Last) -> 
                    remove_covered_intervals(Rest, Result);
                true -> 
                    remove_covered_intervals(Rest, [Interval | Result])
            end
    end.