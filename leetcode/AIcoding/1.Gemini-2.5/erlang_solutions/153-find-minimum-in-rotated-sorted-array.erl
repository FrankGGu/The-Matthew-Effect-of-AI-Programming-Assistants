-module(solution).
-export([findMin/1]).

findMin(Nums) ->
    Len = length(Nums),
    find_min_recursive(Nums, 1, Len).

find_min_recursive(Nums, Low, High) ->
    if Low == High ->
        lists:nth(Low, Nums);
    else
        Mid = Low + (High - Low) div 2,
        MidVal = lists:nth(Mid, Nums),
        HighVal = lists:nth(High, Nums),

        if MidVal > HighVal ->
            find_min_recursive(Nums, Mid + 1, High);
        else
            find_min_recursive(Nums, Low, Mid)
        end
    end.