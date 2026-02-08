-module(solution).
-export([zigzag_traversal_with_skip/2]).

-include_lib("stdlib/include/array.hrl").

zigzag_traversal_with_skip(Grid, K) ->
    Rows = length(Grid),
    Cols = case Grid of
               [] -> 0;
               [H|_] -> length(H)
           end,

    if Rows == 0; Cols == 0 ->
        [];
    true ->
        GridArray = array:from_list(
                      [array:from_list(Row) || Row <- Grid]
                    ),
        traverse_rows_array(GridArray, Rows, Cols, K, 0, 1, [])
    end.

traverse_rows_array(_GridArray, Rows, _Cols, _K, Rows, _Direction, Acc) ->
    lists:reverse(Acc);

traverse_rows_array(GridArray, Rows, Cols, K, CurrentRow, Direction, Acc) ->
    RowArray = array:get(CurrentRow, GridArray),

    NewAcc = case Direction of
                 1 ->
                     traverse_row_lr_array(RowArray, Cols, K, 0, Acc);
                 -1 ->
                     traverse_row_rl_array(RowArray, Cols, K, Cols - 1, Acc)
             end,

    traverse_rows_array(GridArray, Rows, Cols, K, CurrentRow + 1, -Direction, NewAcc).

traverse_row_lr_array(_RowArray, Cols, _K, CurrentCol, Acc) when CurrentCol >= Cols ->
    Acc;
traverse_row_lr_array(RowArray, Cols, K, CurrentCol, Acc) ->
    Element = array:get(CurrentCol, RowArray),
    NewAcc = [Element | Acc],
    NextCol = CurrentCol + 1 + K,
    traverse_row_lr_array(RowArray, Cols, K, NextCol, NewAcc).

traverse_row_rl_array(_RowArray, _Cols, _K, CurrentCol, Acc) when CurrentCol < 0 ->
    Acc;
traverse_row_rl_array(RowArray, Cols, K, CurrentCol, Acc) ->
    Element = array:get(CurrentCol, RowArray),
    NewAcc = [Element | Acc],
    NextCol = CurrentCol - 1 - K,
    traverse_row_rl_array(RowArray, Cols, K, NextCol, NewAcc).