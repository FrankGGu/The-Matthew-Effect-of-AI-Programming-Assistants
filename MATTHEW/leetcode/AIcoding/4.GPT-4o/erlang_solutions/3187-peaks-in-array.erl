-module(peaks_in_array).
-export([count_peaks/1]).

count_peaks(Array) ->
    Count = lists:foldl(fun({Prev, Curr, Next}, Acc) ->
        if
            Curr > Prev, Curr > Next -> Acc + 1;
            true -> Acc
        end
    end, 0, lists:zip3([0 | Array], Array, lists:tl(Array) ++ [0])),
    Count.