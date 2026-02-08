-module(check_matrix).
-export([check_if_matrix_is_good/1]).

check_if_matrix_is_good(Matrix) ->
    N = length(Matrix),
    check_rows(Matrix, N) and check_cols(Matrix, N).

check_rows([], _) ->
    true;
check_rows([Row | Rest], N) ->
    lists:sort(Row) =:= lists:seq(1, N) and check_rows(Rest, N).

check_cols(Matrix, N) ->
    check_cols_helper(lists:seq(0, N - 1), Matrix, N).

check_cols_helper([], _, _) ->
    true;
check_cols_helper([Col | Rest], Matrix, N) ->
    Column = [lists:nth(Col + 1, Row) || Row <- Matrix],
    lists:sort(Column) =:= lists:seq(1, N) and check_cols_helper(Rest, Matrix, N).