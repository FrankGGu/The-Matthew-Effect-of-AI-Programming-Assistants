-module(solution).
-export([highQualityRuneReserve/2]).

highQualityRuneReserve(Runes, K) ->
    SortedRunes = lists:sort(Runes),
    Len = length(SortedRunes),

    if Len < 2 -> 0;
       true ->
            Arr = array:from_list(SortedRunes),
            solve_array(Arr, K, 0, 0, 0, 0, Len)
    end.

solve_array(Arr, K, LeftIdx, RightIdx, CurrentWindowSum, MaxSum, Len) when RightIdx < Len ->
    RuneRight = array:get(RightIdx, Arr),

    {NewLeftIdx, UpdatedCurrentWindowSum} = 
        adjust_left_loop(Arr, K, LeftIdx, CurrentWindowSum, RuneRight),

    NewCurrentWindowSum = UpdatedCurrentWindowSum + RuneRight,

    NewMaxSum = 
        if (RightIdx - NewLeftIdx + 1) >= 2 ->
            max(MaxSum, NewCurrentWindowSum);
        true ->
            MaxSum
        end,

    solve_array(Arr, K, NewLeftIdx, RightIdx + 1, NewCurrentWindowSum, NewMaxSum, Len);

solve_array(_Arr, _K, _LeftIdx, _RightIdx, _CurrentWindowSum, MaxSum, _Len) ->
    MaxSum.

adjust_left_loop(Arr, K, LeftIdx, CurrentWindowSum, RuneRight) ->
    RuneLeft = array:get(LeftIdx, Arr),
    if RuneRight - RuneLeft > K ->
        adjust_left_loop(Arr, K, LeftIdx + 1, CurrentWindowSum - RuneLeft, RuneRight);
    true ->
        {LeftIdx, CurrentWindowSum}
    end.