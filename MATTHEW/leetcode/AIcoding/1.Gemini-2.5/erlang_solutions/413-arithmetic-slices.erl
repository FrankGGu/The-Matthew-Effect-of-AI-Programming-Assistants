-module(solution).
-export([arithmetic_slices/1]).

arithmetic_slices(A) when length(A) < 3 ->
    0;
arithmetic_slices(A) ->
    [A_i_minus_2, A_i_minus_1 | Rest] = A,
    arithmetic_slices_recursive(Rest, A_i_minus_2, A_i_minus_1, 0, 0).

arithmetic_slices_recursive([], _A_i_minus_2, _A_i_minus_1, TotalSlices, _CurrentAPLength) ->
    TotalSlices;
arithmetic_slices_recursive([A_i | T], A_i_minus_2, A_i_minus_1, TotalSlices, CurrentAPLength) ->
    Diff1 = A_i - A_i_minus_1,
    Diff2 = A_i_minus_1 - A_i_minus_2,
    if
        Diff1 == Diff2 ->
            NewCurrentAPLength = CurrentAPLength + 1,
            NewTotalSlices = TotalSlices + NewCurrentAPLength,
            arithmetic_slices_recursive(T, A_i_minus_1, A_i, NewTotalSlices, NewCurrentAPLength);
        true ->
            arithmetic_slices_recursive(T, A_i_minus_1, A_i, TotalSlices, 0)
    end.