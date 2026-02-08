-module(longest_equal_subarray).
-export([longest_equal_subarray/2]).

longest_equal_subarray(Nums, K) ->
    longest_equal_subarray_impl(Nums, K, 0, 0, 0, 0, #{}).

longest_equal_subarray_impl(Nums, K, Left, Right, MaxLen, MaxFreqInWindow, FreqMap) when Right < length(Nums) ->
    CurrentNum = lists:nth(Right + 1, Nums),

    NewFreqCurrentNum = maps:get(CurrentNum, FreqMap, 0) + 1,
    NewFreqMap = maps:put(CurrentNum, NewFreqCurrentNum, FreqMap),

    NewMaxFreqInWindow = max(MaxFreqInWindow, NewFreqCurrentNum),

    {NewLeft, FinalFreqMap} = 
        shrink_window_if_needed(Nums, K, Left, Right, NewMaxFreqInWindow, NewFreqMap),

    FinalWindowLength = Right - NewLeft + 1,
    UpdatedMaxLen = max(MaxLen, FinalWindowLength),

    longest_equal_subarray_impl(Nums, K, NewLeft, Right + 1, UpdatedMaxLen, NewMaxFreqInWindow, FinalFreqMap);

longest_equal_subarray_impl(_Nums, _K, _Left, _Right, MaxLen, _MaxFreqInWindow, _FreqMap) ->
    MaxLen.

shrink_window_if_needed(Nums, K, Left, Right, MaxFreqInWindow, FreqMap) ->
    WindowLength = Right - Left + 1,
    if
        WindowLength - MaxFreqInWindow > K ->
            LeftNum = lists:nth(Left + 1, Nums),
            UpdatedFreqMap = maps:update_with(LeftNum, fun(V) -> V - 1 end, FreqMap),
            shrink_window_if_needed(Nums, K, Left + 1, Right, MaxFreqInWindow, UpdatedFreqMap);
        true ->
            {Left, FreqMap}
    end.