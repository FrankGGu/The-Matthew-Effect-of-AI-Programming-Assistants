-module(solution).
-export([largest_local/1]).

get_element(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

max_of_3x3(Grid, R, C) ->
    max_of_3x3_loop(Grid, R, C, 0, 0, 0).

max_of_3x3_loop(Grid, R, C, Dr, Dc, CurrentMax) when Dr < 3 ->
    NewR = R + Dr,
    NewC = C + Dc,
    Val = get_element(Grid, NewR, NewC),
    NextMax = max(CurrentMax, Val),
    case Dc of
        2 ->
            max_of_3x3_loop(Grid, R, C, Dr + 1, 0, NextMax);
        _ ->
            max_of_3x3_loop(Grid, R, C, Dr, Dc + 1, NextMax)
    end;
max_of_3x3_loop(_Grid, _R, _C, 3, _Dc, CurrentMax) ->
    CurrentMax.

largest_local(Grid) ->
    N = length(Grid),
    ResultSize = N - 2,
    lists:reverse(largest_local_rows(Grid, 0, ResultSize, [])).

largest_local_rows(Grid, R, ResultSize, AccRows) when R < ResultSize ->
    NewRow = lists:reverse(largest_local_cols(Grid, R, 0, ResultSize, [])),
    largest_local_rows(Grid, R + 1, ResultSize, [NewRow | AccRows]);
largest_local_rows(_Grid, _R, _ResultSize, AccRows) ->
    AccRows.

largest_local_cols(Grid, R, C, ResultSize, AccCols) when C < ResultSize ->
    MaxVal = max_of_3x3(Grid, R, C),
    largest_local_cols(Grid, R, C + 1, ResultSize, [MaxVal | AccCols]);
largest_local_cols(_Grid, _R, _C, _ResultSize, AccCols) ->
    AccCols.