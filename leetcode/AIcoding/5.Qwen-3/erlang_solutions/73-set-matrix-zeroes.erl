-module(set_matrix_zeroes).
-export([set_zeroes/1]).

set_zeroes(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> Matrix;
        true ->
            Cols = length(hd(Matrix)),
            {HasFirstRow, HasFirstCol} = check_first_row_and_col(Matrix, Rows, Cols),
            set_first_row_and_col(Matrix, Rows, Cols, HasFirstRow, HasFirstCol),
            set_other_zeros(Matrix, Rows, Cols)
    end.

check_first_row_and_col(_, _, 0) -> {false, false};
check_first_row_and_col(Matrix, Rows, Cols) ->
    FirstRow = lists:nth(1, Matrix),
    FirstCol = [lists:nth(1, Row) || Row <- Matrix],
    HasFirstRow = lists:member(0, FirstRow),
    HasFirstCol = lists:member(0, FirstCol),
    {HasFirstRow, HasFirstCol}.

set_first_row_and_col(Matrix, Rows, Cols, HasFirstRow, HasFirstCol) ->
    case HasFirstRow of
        true -> lists:foreach(fun(_) -> lists:put(1, 0, hd(Matrix)) end, lists:seq(1, Cols));
        false -> ok
    end,
    case HasFirstCol of
        true -> lists:foreach(fun(Row) -> lists:put(1, 0, Row) end, tl(Matrix));
        false -> ok
    end.

set_other_zeros(Matrix, Rows, Cols) ->
    lists:foreach(
        fun(RowIndex) ->
            lists:foreach(
                fun(ColIndex) ->
                    if
                        lists:nth(RowIndex, Matrix) == [] -> ok;
                        true ->
                            Value = lists:nth(ColIndex, lists:nth(RowIndex, Matrix)),
                            if
                                Value == 0 ->
                                    set_row(Matrix, RowIndex, Cols),
                                    set_col(Matrix, ColIndex, Rows);
                                true -> ok
                            end
                    end
                end,
                lists:seq(2, Cols)
            )
        end,
        lists:seq(2, Rows)
    ).

set_row(_, _, 0) -> ok;
set_row(Matrix, RowIndex, ColIndex) ->
    lists:put(ColIndex, 0, lists:nth(RowIndex, Matrix)),
    set_row(Matrix, RowIndex, ColIndex - 1).

set_col(_, _, 0) -> ok;
set_col(Matrix, ColIndex, RowIndex) ->
    lists:put(RowIndex, 0, lists:nth(ColIndex, lists:nth(RowIndex, Matrix))),
    set_col(Matrix, ColIndex, RowIndex - 1).