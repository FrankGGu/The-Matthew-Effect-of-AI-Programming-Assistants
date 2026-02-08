-module(solution).
-export([peak_index_in_mountain_array/1]).

peak_index_in_mountain_array(Mountain) ->
    PeakIndex = find_peak(Mountain, 0, length(Mountain) - 1),
    PeakIndex.

find_peak(Mountain, Left, Right) ->
    if
        Left < Right ->
            Mid = (Left + Right) div 2,
            if
                Mountain[Mid] < Mountain[Mid + 1] ->
                    find_peak(Mountain, Mid + 1, Right);
                true ->
                    find_peak(Mountain, Left, Mid)
            end;
        true ->
            Left
    end.