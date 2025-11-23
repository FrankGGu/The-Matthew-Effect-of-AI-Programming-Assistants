-module(find_duplicate).
-export([find_duplicate/1]).

find_duplicate(Nums) ->
    find_duplicate_helper(Nums, 0, length(Nums) - 1).

find_duplicate_helper(Nums, Low, High) ->
    if Low >= High ->
        Low
    else
        Mid = Low + (High - Low) div 2,
        Count = count_less_equal(Nums, Mid),
        if Count > Mid ->
            find_duplicate_helper(Nums, Low, Mid)
        else
            find_duplicate_helper(Nums, Mid + 1, High)
        end
    end.

count_less_equal(Nums, Target) ->
    count_less_equal_helper(Nums, Target, 0).

count_less_equal_helper([], _, Acc) ->
    Acc;
count_less_equal_helper([H|T], Target, Acc) ->
    if H =< Target ->
        count_less_equal_helper(T, Target, Acc + 1)
    else
        count_less_equal_helper(T, Target, Acc)
    end.