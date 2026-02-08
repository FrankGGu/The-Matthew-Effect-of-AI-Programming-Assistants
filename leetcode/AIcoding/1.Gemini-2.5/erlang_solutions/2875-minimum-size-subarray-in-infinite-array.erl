-module(solution).
-export([min_subarray_sum/2]).

min_subarray_sum(Nums, Target) ->
    N = length(Nums),
    SumNums = lists:sum(Nums),

    Infinity = 1_000_000_000_000_000, 

    NumsArr = array:from_list(Nums),
    Nums2Arr = array:from_list(Nums ++ Nums),
    N2 = 2 * N,

    NumFullArrays = Target div SumNums,
    RemainingTarget = Target rem SumNums,

    Candidate1Len = 
        case RemainingTarget of
            0 ->
                NumFullArrays * N;
            _ -> 
                MinLenSubarrayRemaining = sliding_window(Nums2Arr, RemainingTarget, N2, Infinity),
                NumFullArrays * N + MinLenSubarrayRemaining
        end,

    Candidate2Len =
        case NumFullArrays > 0 of
            true ->
                TargetForSubarray = RemainingTarget + SumNums,
                MinLenSubarrayWrapped = sliding_window(Nums2Arr, TargetForSubarray, N2, Infinity),
                (NumFullArrays - 1) * N + MinLenSubarrayWrapped;
            false ->
                Infinity
        end,

    FinalMinLen = min(Candidate1Len, Candidate2Len),

    case FinalMinLen >= Infinity of
        true -> -1;
        false -> FinalMinLen
    end.

sliding_window(Arr, Target, ArrLen, MinLenInit) ->
    Left = 0,
    CurrentSum = 0,

    sliding_window_loop(Arr, Target, ArrLen, Left, 0, CurrentSum, MinLenInit).

sliding_window_loop(Arr, Target, ArrLen, Left, Right, CurrentSum, MinLen) when Right < ArrLen ->
    Val = array:get(Right, Arr),
    NewCurrentSum = CurrentSum + Val,

    {UpdatedMinLen, UpdatedLeft, FinalCurrentSum} = 
        slide_left_pointer(Arr, Target, ArrLen, Left, Right, NewCurrentSum, MinLen),

    sliding_window_loop(Arr, Target, ArrLen, UpdatedLeft, Right + 1, FinalCurrentSum, UpdatedMinLen);
sliding_window_loop(_Arr, _Target, _ArrLen, _Left, _Right, _CurrentSum, MinLen) ->
    MinLen.

slide_left_pointer(Arr, Target, _ArrLen, Left, Right, CurrentSum, MinLen) ->
    case CurrentSum >= Target of
        true ->
            NewMinLen = min(MinLen, Right - Left + 1),
            ValLeft = array:get(Left, Arr),
            NewCurrentSum = CurrentSum - ValLeft,
            NewLeft = Left + 1,
            slide_left_pointer(Arr, Target, _ArrLen, NewLeft, Right, NewCurrentSum, NewMinLen);
        false ->
            {MinLen, Left, CurrentSum}
    end.