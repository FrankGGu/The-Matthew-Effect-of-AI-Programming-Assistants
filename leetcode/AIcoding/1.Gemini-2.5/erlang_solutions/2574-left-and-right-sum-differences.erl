-module(solution).
-export([left_right_sum_differences/1]).

left_right_sum_differences(Nums) ->
    TotalSum = lists:sum(Nums),
    calculate_differences(Nums, TotalSum, 0, []).

calculate_differences([], _TotalSum, _CurrentLeftSum, AccResult) ->
    lists:reverse(AccResult);
calculate_differences([H|T], TotalSum, CurrentLeftSum, AccResult) ->
    CurrentRightSum = TotalSum - CurrentLeftSum - H,
    Difference = math:abs(CurrentLeftSum - CurrentRightSum),
    NewLeftSum = CurrentLeftSum + H,
    calculate_differences(T, TotalSum, NewLeftSum, [Difference|AccResult]).