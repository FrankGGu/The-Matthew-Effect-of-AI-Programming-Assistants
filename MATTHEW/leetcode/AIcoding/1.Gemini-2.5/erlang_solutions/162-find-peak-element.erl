-module(solution).
-export([findPeakElement/1]).

findPeakElement(Nums) ->
    Len = length(Nums),
    find_peak_bs(Nums, 0, Len - 1).

find_peak_bs(Nums, Low, High) when Low == High ->
    Low;
find_peak_bs(Nums, Low, High) ->
    Mid = Low + (High - Low) div 2,
    ValMid = lists:nth(Mid + 1, Nums),
    ValMidPlus1 = lists:nth(Mid + 2, Nums),

    if
        ValMid > ValMidPlus1 ->
            find_peak_bs(Nums, Low, Mid);
        true ->
            find_peak_bs(Nums, Mid + 1, High)
    end.