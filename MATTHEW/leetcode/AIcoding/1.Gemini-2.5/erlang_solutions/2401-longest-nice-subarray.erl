-module(solution).
-export([longest_nice_subarray/1]).

longest_nice_subarray(Nums) ->
    Arr = array:from_list(Nums),
    Len = array:size(Arr),
    solve(Arr, Len, 0, 0, 0, 0).

solve(Arr, Len, LeftIdx, RightIdx, CurrentMask, MaxLen) ->
    if RightIdx >= Len ->
        MaxLen;
    true ->
        Val = array:get(RightIdx, Arr),

        {NewLeftIdx, NewCurrentMask} = shrink_window_array(Arr, LeftIdx, CurrentMask, Val),

        NewCurrentMaskExtended = NewCurrentMask bor Val,
        NewMaxLen = max(MaxLen, RightIdx - NewLeftIdx + 1),

        solve(Arr, Len, NewLeftIdx, RightIdx + 1, NewCurrentMaskExtended, NewMaxLen)
    end.

shrink_window_array(Arr, LeftIdx, CurrentMask, Val) ->
    if (CurrentMask band Val) == 0 ->
        {LeftIdx, CurrentMask};
    true ->
        LeftVal = array:get(LeftIdx, Arr),
        NewCurrentMask = CurrentMask bxor LeftVal,
        shrink_window_array(Arr, LeftIdx + 1, NewCurrentMask, Val)
    end.