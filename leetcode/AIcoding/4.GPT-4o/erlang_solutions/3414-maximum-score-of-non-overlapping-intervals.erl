-module(solution).
-export([max_non_overlapping_score/1]).

max_non_overlapping_score(Intervals) ->
    SortedIntervals = lists:sort(fun({Start1, End1}, {Start2, End2}) -> 
        case End1 - Start1 < End2 - Start2 of 
            true -> true; 
            false -> false 
        end 
    end, Intervals),
    max_score(SortedIntervals, 0, -1).

max_score([], Score, _) -> Score;
max_score([{Start, End} | Rest], Score, LastEnd) ->
    if 
        Start >= LastEnd -> 
            max_score(Rest, Score + (End - Start), End);
        true -> 
            max_score(Rest, Score, LastEnd)
    end.