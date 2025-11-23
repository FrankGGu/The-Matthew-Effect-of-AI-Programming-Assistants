-module(solution).
-export([min_difference/1]).

min_difference(Numbers) ->
    Sorted = lists:sort(Numbers),
    Length = length(Sorted),
    MinDiff = case Length of
        L when L > 6 -> 
            Min = lists:nth(0, Sorted) + lists:nth(1, Sorted) + lists:nth(2, Sorted),
            Max = lists:nth(Length - 1, Sorted) + lists:nth(Length - 2, Sorted) + lists:nth(Length - 3, Sorted),
            Max - Min;
        _ -> 
            0
    end,
    MinDiff.