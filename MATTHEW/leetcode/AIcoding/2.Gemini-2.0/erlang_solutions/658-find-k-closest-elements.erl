-module(find_k_closest_elements).
-export([find_k_closest/3]).

find_k_closest(Arr, K, X) ->
    Len = length(Arr),
    {L, R} = find_closest_range(Arr, X, 0, Len - 1, K),
    lists:sublist(Arr, L + 1, R - L + 1).

find_closest_range(Arr, X, Low, High, K) ->
    if High - Low + 1 =< K then
        {Low, High}
    else
        Mid = Low + (High - Low) div 2,
        if X <= lists:nth(Mid + 1, Arr) then
            find_closest_range(Arr, X, Low, Mid, K)
        else
            find_closest_range(Arr, X, Mid + 1, High, K)
        end
    end.

find_closest_range(Arr, X, Low, High, K) when High - Low + 1 > K ->
    Mid = Low + (High - Low) div 2,
    if (X - lists:nth(Low + 1, Arr)) > (lists:nth(High + 1, Arr) - X) then
        find_closest_range(Arr, X, Low + 1, High, K)
    else
        find_closest_range(Arr, X, Low, High - 1, K)
    end.