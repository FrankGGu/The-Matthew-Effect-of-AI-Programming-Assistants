-module(solution).
-export([is_toeplitz_matrix/1]).

is_toeplitz_matrix([]) -> true;
is_toeplitz_matrix([[]]) -> true;
is_toeplitz_matrix(Matrix) ->
    check_rows(Matrix).

check_rows([_]) -> true;
check_rows([Row1, Row2 | RestRows]) ->
    check_row_pair(Row1, Row2) andalso check_rows([Row2 | RestRows]).

check_row_pair([_], [_]) -> true;
check_row_pair([H1 | T1], [_ | T2]) ->
    H1 == hd(T2) andalso check_row_pair(T1, T2).