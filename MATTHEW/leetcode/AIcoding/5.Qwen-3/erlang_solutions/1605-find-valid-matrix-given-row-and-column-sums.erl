-module(solution).
-export([find_matrix/2]).

find_matrix(Rows, Cols) ->
    find_matrix(Rows, Cols, []).

find_matrix([], _, Acc) ->
    lists:reverse(Acc);
find_matrix([R | Rs], Cols, Acc) ->
    Row = generate_row(R, Cols),
    find_matrix(Rs, Cols, [Row | Acc]).

generate_row(Sum, N) ->
    generate_row(Sum, N, []).

generate_row(0, 0, Acc) ->
    lists:reverse(Acc);
generate_row(Sum, N, Acc) ->
    Val = min(Sum, lists:last(Acc) || Acc /= [] else Sum end),
    generate_row(Sum - Val, N - 1, [Val | Acc]).