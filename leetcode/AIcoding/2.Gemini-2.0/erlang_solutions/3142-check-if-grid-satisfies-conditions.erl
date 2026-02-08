-module(check_grid_conditions).
-export([check_if_grid_satisfies_conditions/1]).

check_if_grid_satisfies_conditions(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    check_rows(Grid, Rows, Cols) and check_cols(Grid, Rows, Cols).

check_rows(Grid, Rows, Cols) ->
    lists:all(fun(Row) ->
                      lists:all(fun(X) ->
                                        lists:sum([if Y > X then 1 else 0 end || Y <- Row]) >
                                        lists:sum([if Y < X then 1 else 0 end || Y <- Row])
                                end, Row)
              end, Grid).

check_cols(Grid, Rows, Cols) ->
    transpose(Grid,Rows,Cols) ->
    transpose(Grid,Rows,Cols).

transpose(Grid,Rows, Cols) ->
    transpose(Grid,Rows,Cols).

transpose(Grid,Rows,Cols) ->
    transpose_helper(Grid, Rows, Cols, []).

transpose_helper(_Grid, 0, _Cols, Acc) ->
    lists:reverse(Acc);
transpose_helper(Grid, Rows, Cols, Acc) ->
    Col = [lists:nth(Rows, Row) || Row <- Grid],
    transpose_helper(Grid, Rows - 1, Cols, [Col|Acc]).

transpose(Grid,Rows,Cols) ->
    Transposed = lists:zip(Grid),
    lists:all(fun(Row) ->
                      lists:all(fun(X) ->
                                        lists:sum([if Y > X then 1 else 0 end || Y <- Row]) >
                                        lists:sum([if Y < X then 1 else 0 end || Y <- Row])
                                end, Row)
              end, Transposed).