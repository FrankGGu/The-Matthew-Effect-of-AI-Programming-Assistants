-module(solution).
-export([good_subarrays/2]).

good_subarrays(Nums, K) ->
    Arr = array:from_list(Nums),
    count_at_most(Arr, K) - count_at_most(Arr, K - 1).

count_at_most(Arr, MaxK) ->
    Size = array:size(Arr),
    count_at_most_loop(Arr, Size, MaxK, 0, 0, 0, #{}, 0).

count_at_most_loop(Arr, Size, MaxK, LeftIdx, RightIdx, CurrentPairs, FreqMap, AccAns) ->
    if RightIdx < Size ->
        Val = array:get(RightIdx, Arr),
        CurrentFreq = maps:get(Val, FreqMap, 0),
        NewPairs = CurrentPairs + CurrentFreq,
        NewFreqMap = maps:put(Val, CurrentFreq + 1, FreqMap),

        {AdjustedLeftIdx, AdjustedPairs, AdjustedFreqMap} = adjust_window_loop(Arr, LeftIdx, NewPairs, NewFreqMap, MaxK),

        NewAccAns = AccAns + (RightIdx - AdjustedLeftIdx + 1),

        count_at_most_loop(Arr, Size, MaxK, AdjustedLeftIdx, RightIdx + 1, AdjustedPairs, AdjustedFreqMap, NewAccAns);
    true ->
        AccAns
    end.

adjust_window_loop(Arr, LeftIdx, CurrentPairs, FreqMap, MaxK) ->
    if CurrentPairs > MaxK ->
        ValLeft = array:get(LeftIdx, Arr),
        FreqValLeft = maps:get(ValLeft, FreqMap),
        NewPairs = CurrentPairs - (FreqValLeft - 1),
        NewFreqMap = maps:put(ValLeft, FreqValLeft - 1, FreqMap),
        adjust_window_loop(Arr, LeftIdx + 1, NewPairs, NewFreqMap, MaxK);
    true ->
        {LeftIdx, CurrentPairs, FreqMap}
    end.