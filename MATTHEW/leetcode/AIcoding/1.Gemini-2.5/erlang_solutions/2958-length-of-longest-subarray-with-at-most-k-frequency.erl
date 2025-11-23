-module(solution).
-export([longest_subarray/2]).

longest_subarray(Nums, K) ->
    Arr = array:from_list(Nums),
    solve(Arr, K, 0, 0, #{}, 0).

solve(Arr, K, LeftIdx, RightIdx, FreqMap, MaxLen) ->
    if RightIdx >= array:size(Arr) ->
        MaxLen;
    else
        Num = array:get(RightIdx, Arr),
        NewFreqMap = maps:update_with(Num, fun(V) -> V + 1 end, 1, FreqMap),
        CurrentFreq = maps:get(Num, NewFreqMap),

        {FinalLeftIdx, FinalFreqMap} =
            if CurrentFreq > K ->
                shrink_left(Arr, K, Num, LeftIdx, NewFreqMap);
            else
                {LeftIdx, NewFreqMap}
            end,

        NewMaxLen = max(MaxLen, RightIdx - FinalLeftIdx + 1),
        solve(Arr, K, FinalLeftIdx, RightIdx + 1, FinalFreqMap, NewMaxLen)
    end.

shrink_left(Arr, K, TargetNum, LIdx, FMap) ->
    LeftElem = array:get(LIdx, Arr),
    UpdatedFMap = maps:update_with(LeftElem, fun(V) -> V - 1 end, 0, FMap),

    case maps:get(TargetNum, UpdatedFMap) of
        Freq when Freq > K ->
            shrink_left(Arr, K, TargetNum, LIdx + 1, UpdatedFMap);
        _ ->
            {LIdx + 1, UpdatedFMap}
    end.