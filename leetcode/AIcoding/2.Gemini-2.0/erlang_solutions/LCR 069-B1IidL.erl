-module(peak_index_in_mountain_array).
-export([peak_index_in_mountain_array/1]).

peak_index_in_mountain_array(Arr) ->
    peak_index_in_mountain_array(Arr, 0, length(Arr) - 1).

peak_index_in_mountain_array(Arr, Low, High) ->
    if Low =< High ->
        Mid = (Low + High) div 2,
        if Arr !! Mid > Arr !! (Mid + 1) ->
            if Arr !! Mid > Arr !! (Mid - 1) ->
                Mid;
            true ->
                peak_index_in_mountain_array(Arr, Low, Mid - 1)
            end;
        true ->
            peak_index_in_mountain_array(Arr, Mid + 1, High)
        end;
    true ->
        -1
    end.