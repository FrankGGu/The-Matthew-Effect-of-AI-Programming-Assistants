-module(solution).
-export([check_valid/1]).

check_valid(Matrix) ->
    N = length(Matrix),
    check_rows(Matrix, N),
    check_cols(Matrix, N),
    true.

check_rows([], _) -> true;
check_rows([Row|Rest], N) ->
    Set = sets:from_list(Row),
    if
        sets:size(Set) == N andalso lists:all(fun(X) -> X >= 1 andalso X =< N end, Row) ->
            check_rows(Rest, N);
        true ->
            false
    end.

check_cols(_, _) -> true;
check_cols(Matrix, N) ->
    check_cols(Matrix, N, 0).

check_cols(_, _, N) -> true;
check_cols(Matrix, N, Col) ->
    Column = [lists:nth(Col+1, Row) || Row <- Matrix],
    Set = sets:from_list(Column),
    if
        sets:size(Set) == N andalso lists:all(fun(X) -> X >= 1 andalso X =< N end, Column) ->
            check_cols(Matrix, N, Col+1);
        true ->
            false
    end.