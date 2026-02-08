-module(solution).
-export([peak_index_in_mountain_array/1]).

peak_index_in_mountain_array(A) ->
    Len = length(A),
    binary_search(A, 0, Len - 1).

binary_search(A, Low, High) ->
    if Low == High ->
        Low;
    true ->
        Mid = Low + (High - Low) div 2,
        MidVal = lists:nth(Mid + 1, A),
        MidPlus1Val = lists:nth(Mid + 2, A),
        if MidVal < MidPlus1Val ->
            binary_search(A, Mid + 1, High);
        true ->
            binary_search(A, Low, Mid)
        end
    end.