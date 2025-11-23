-module(solution).
-export([count_intervals/2]).

count_intervals(Intervals, Number) ->
    lists:foldl(fun({Start, End}, Acc) ->
        if
            Number >= Start andalso Number =< End -> 
                Acc + 1;
            true -> 
                Acc
        end
    end, 0, Intervals).