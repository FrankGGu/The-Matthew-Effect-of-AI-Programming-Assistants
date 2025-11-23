-module(solution).
-export([subarraysWithKDistinct/2]).

subarraysWithKDistinct(A, K) ->
    ActualArray = array:from_list(A),
    count_at_most(ActualArray, K) - count_at_most(ActualArray, K - 1).

count_at_most(Array, K) ->
    count_at_most_recursive(Array, K, 0, 0, 0, #{}, 0).

count_at_most_recursive(Array, K, Left, Right, CurrentCount, FreqMap, NumDistinct) ->
    ArrayLen = array:size(Array),
    if Right == ArrayLen ->
        CurrentCount;
    true ->
        Element = array:get(Right, Array),

        NewFreqMap1 = maps:update_with(Element, fun(V) -> V + 1 end, 1, FreqMap),
        OldFreq = maps:get(Element, FreqMap, 0),
        NewNumDistinct1 = if OldFreq == 0 -> NumDistinct + 1; true -> NumDistinct end,

        {AdjustedLeft, AdjustedFreqMap, AdjustedNumDistinct} =
            adjust_window_from_left_array(Array, K, Left, NewFreqMap1, NewNumDistinct1),

        NewCount = CurrentCount + (Right - AdjustedLeft + 1),

        count_at_most_recursive(Array, K, AdjustedLeft, Right + 1, NewCount, AdjustedFreqMap, AdjustedNumDistinct)
    end.

adjust_window_from_left_array(_Array, K, Left, FreqMap, NumDistinct) when NumDistinct =< K ->
    {Left, FreqMap, NumDistinct};
adjust_window_from_left_array(Array, K, Left, FreqMap, NumDistinct) ->
    LeftElement = array:get(Left, Array),
    NewFreqMap = maps:update_with(LeftElement, fun(V) -> V - 1 end, 0, FreqMap),
    NewNumDistinct = if maps:get(LeftElement, FreqMap, 0) == 1 -> NumDistinct - 1; true -> NumDistinct end,
    adjust_window_from_left_array(Array, K, Left + 1, NewFreqMap, NewNumDistinct).