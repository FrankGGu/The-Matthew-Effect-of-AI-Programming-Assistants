-module(solution).
-export([maximum_beautiful_towers/1]).

maximum_beautiful_towers(MaxHeightsList) ->
    N = length(MaxHeightsList),
    MaxHeightsTuple = list_to_tuple(MaxHeightsList),

    maximum_beautiful_towers_loop(0, N, MaxHeightsTuple, 0).

maximum_beautiful_towers_loop(P, N, MaxHeightsTuple, CurrentMaxSum) when P < N ->
    PeakHeight = element(P + 1, MaxHeightsTuple),

    LeftSum = calculate_left_sum(P - 1, PeakHeight, MaxHeightsTuple, PeakHeight),

    RightSum = calculate_right_sum(P + 1, N, PeakHeight, MaxHeightsTuple, 0),

    TotalSum = LeftSum + RightSum,

    NewMaxSum = max(CurrentMaxSum, TotalSum),

    maximum_beautiful_towers_loop(P + 1, N, MaxHeightsTuple, NewMaxSum);
maximum_beautiful_towers_loop(_P, _N, _MaxHeightsTuple, CurrentMaxSum) ->
    CurrentMaxSum.

calculate_left_sum(Index, CurrentHeight, MaxHeightsTuple, AccSum) when Index >= 0 ->
    MaxAllowedHeight = element(Index + 1, MaxHeightsTuple),
    NewHeight = min(CurrentHeight, MaxAllowedHeight),
    calculate_left_sum(Index - 1, NewHeight, MaxHeightsTuple, AccSum + NewHeight);
calculate_left_sum(_Index, _CurrentHeight, _MaxHeightsTuple, AccSum) ->
    AccSum.

calculate_right_sum(Index, N, CurrentHeight, MaxHeightsTuple, AccSum) when Index < N ->
    MaxAllowedHeight = element(Index + 1, MaxHeightsTuple),
    NewHeight = min(CurrentHeight, MaxAllowedHeight),
    calculate_right_sum(Index + 1, N, NewHeight, MaxHeightsTuple, AccSum + NewHeight);
calculate_right_sum(_Index, _N, _CurrentHeight, _MaxHeightsTuple, AccSum) ->
    AccSum.