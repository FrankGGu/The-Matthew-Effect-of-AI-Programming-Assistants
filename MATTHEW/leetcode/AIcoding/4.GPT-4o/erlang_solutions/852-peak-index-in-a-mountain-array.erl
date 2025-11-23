-module(solution).
-export([peak_index_in_mountain_array/1]).

peak_index_in_mountain_array(MountainArray) ->
    PeakIndex = binary_search(MountainArray, 0, length(MountainArray) - 1),
    PeakIndex.

binary_search(MountainArray, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    if
        MountainArray[Mid] < MountainArray[Mid + 1] ->
            binary_search(MountainArray, Mid + 1, High);
        true ->
            binary_search(MountainArray, Low, Mid)
    end;
binary_search(_, Low, Low) ->
    Low.