-module(solution).
-export([hourglass_sum/1]).

-spec hourglass_sum(Grid :: [[integer()]]) -> integer().
hourglass_sum(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    GridArray = list_to_array_of_arrays(Grid),
    MaxSum = -7000001,
    calculate_max_sum_array(GridArray, M, N, 0, 0, MaxSum).

list_to_array_of_arrays(Grid) ->
    RowsAsArrays = [array:from_list(Row) || Row <- Grid],
    array:from_list(RowsAsArrays).

calculate_max_sum_array(GridArray, M, N, I, J, CurrentMax) when I =< M - 3 ->
    if J =< N - 3 ->
        Sum = get_hourglass_sum_array(GridArray, I, J),
        NewMax = max(CurrentMax, Sum),
        calculate_max_sum_array(GridArray, M, N, I, J + 1, NewMax);
    true ->
        calculate_max_sum_array(GridArray, M, N, I + 1, 0, CurrentMax)
    end;
calculate_max_sum_array(_GridArray, _M, _N, _I, _J, CurrentMax) ->
    CurrentMax.

get_hourglass_sum_array(GridArray, R, C) ->
    RowR = array:get(R, GridArray),
    RowR1 = array:get(R + 1, GridArray),
    RowR2 = array:get(R + 2, GridArray),
    E1 = array:get(C, RowR),
    E2 = array:get(C + 1, RowR),
    E3 = array:get(C + 2, RowR),
    E4 = array:get(C + 1, RowR1),
    E5 = array:get(C, RowR2),
    E6 = array:get(C + 1, RowR2),
    E7 = array:get(C + 2, RowR2),
    E1 + E2 + E3 + E4 + E5 + E6 + E7.