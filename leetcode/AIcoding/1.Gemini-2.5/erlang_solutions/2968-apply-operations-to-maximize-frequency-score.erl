-module(solution).
-export([solution/2]).

solution(Nums, K) ->
    SortedNums = lists:sort(Nums),
    Array = array:from_list(SortedNums),
    Len = array:size(Array),

    slide(0, 0, 0, 0, Array, K, Len).

slide(Left, CurrentSum, MaxFreq, Right, Array, MaxK, Len) ->
    if Right == Len ->
        MaxFreq
    else
        CurrentVal = array:get(Right, Array),
        NewCurrentSum = CurrentSum + CurrentVal,

        {NewLeft, FinalCurrentSum} = adjust_window(Left, NewCurrentSum, Right, CurrentVal, Array, MaxK),

        NewMaxFreq = max(MaxFreq, Right - NewLeft + 1),

        slide(NewLeft, FinalCurrentSum, NewMaxFreq, Right + 1, Array, MaxK, Len)
    end.

adjust_window(Left, CurrentSum, Right, CurrentVal, Array, MaxK) ->
    WindowLen = Right - Left + 1,
    Cost = (CurrentVal * WindowLen) - CurrentSum,

    if Cost > MaxK ->
        LeftVal = array:get(Left, Array),
        adjust_window(Left + 1, CurrentSum - LeftVal, Right, CurrentVal, Array, MaxK)
    else
        {Left, CurrentSum}
    end.