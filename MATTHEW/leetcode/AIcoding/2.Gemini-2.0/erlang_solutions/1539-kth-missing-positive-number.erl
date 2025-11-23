-module(kth_missing_positive_number).
-export([find_kth_positive/2]).

find_kth_positive(Arr, K) ->
    find_kth_positive(Arr, K, 0, length(Arr) - 1).

find_kth_positive(Arr, K, Low, High) ->
    if Low > High ->
        K;
    true ->
        Mid = Low + (High - Low) div 2,
        Missing = Arr ! Mid - (Mid + 1),
        if Missing < K ->
            find_kth_positive(Arr, K - Missing, Mid + 1, High);
        true ->
            find_kth_positive(Arr, K, Low, Mid - 1)
        end
    end.