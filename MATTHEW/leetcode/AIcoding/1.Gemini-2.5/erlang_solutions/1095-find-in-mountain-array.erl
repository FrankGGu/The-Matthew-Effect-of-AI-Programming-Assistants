-module(solution).
-export([findInMountainArray/2]).

findInMountainArray(MountainArray, Target) ->
    Len = mountain_array:length(MountainArray),
    Peak = find_peak(MountainArray, 0, Len - 1),

    ResultInc = binary_search_increasing(MountainArray, Target, 0, Peak),
    case ResultInc of
        -1 ->
            binary_search_decreasing(MountainArray, Target, Peak + 1, Len - 1);
        _ ->
            ResultInc
    end.

find_peak(MountainArray, Low, High) ->
    if Low == High ->
        Low;
    true ->
        Mid = Low + (High - Low) div 2,
        ValMid = mountain_array:get(MountainArray, Mid),
        ValMidPlus1 = mountain_array:get(MountainArray, Mid + 1),
        if ValMid < ValMidPlus1 ->
            find_peak(MountainArray, Mid + 1, High);
        true ->
            find_peak(MountainArray, Low, Mid)
        end
    end.

binary_search_increasing(MountainArray, Target, Low, High) ->
    if Low > High ->
        -1;
    true ->
        Mid = Low + (High - Low) div 2,
        ValMid = mountain_array:get(MountainArray, Mid),
        if ValMid == Target ->
            Mid;
        ValMid < Target ->
            binary_search_increasing(MountainArray, Target, Mid + 1, High);
        true ->
            binary_search_increasing(MountainArray, Target, Low, Mid - 1)
        end
    end.

binary_search_decreasing(MountainArray, Target, Low, High) ->
    if Low > High ->
        -1;
    true ->
        Mid = Low + (High - Low) div 2,
        ValMid = mountain_array:get(MountainArray, Mid),
        if ValMid == Target ->
            Mid;
        ValMid < Target ->
            binary_search_decreasing(MountainArray, Target, Low, Mid - 1);
        true ->
            binary_search_decreasing(MountainArray, Target, Mid + 1, High)
        end
    end.