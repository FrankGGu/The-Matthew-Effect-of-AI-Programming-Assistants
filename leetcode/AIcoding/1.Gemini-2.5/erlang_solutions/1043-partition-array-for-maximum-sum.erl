-module(solution).
-export([max_sum_after_partitioning/2]).

max_sum_after_partitioning(Arr, K) ->
    N = length(Arr),
    ArrA = array:from_list(Arr),

    Dp0 = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),

    FinalDp = lists:foldl(fun(I, CurrentDp) ->
        MaxSumForCurrentI = calculate_inner_loop(I - 1,
                                               max(0, I - K),
                                               0,
                                               0,
                                               CurrentDp, ArrA, I),
        array:set(I, MaxSumForCurrentI, CurrentDp)
    end, Dp0, lists:seq(1, N)),

    array:get(N, FinalDp).

calculate_inner_loop(J, J_end, MaxElementInCurrentSubarray, CurrentMaxDpForI, DpArray, ArrArray, I) when J >= J_end ->
    ArrJ = array:get(J, ArrArray),

    NewMaxElementInCurrentSubarray = max(MaxElementInCurrentSubarray, ArrJ),

    LengthOfSubarray = I - J,

    DpJ = array:get(J, DpArray),

    CandidateSum = DpJ + NewMaxElementInCurrentSubarray * LengthOfSubarray,

    NewCurrentMaxDpForI = max(CurrentMaxDpForI, CandidateSum),

    calculate_inner_loop(J - 1, J_end, NewMaxElementInCurrentSubarray, NewCurrentMaxDpForI, DpArray, ArrArray, I);
calculate_inner_loop(_J, _J_end, _MaxElementInCurrentSubarray, CurrentMaxDpForI, _DpArray, _ArrArray, _I) ->
    CurrentMaxDpForI.