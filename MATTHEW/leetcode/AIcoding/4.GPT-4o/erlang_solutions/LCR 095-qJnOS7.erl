-module(longest_common_subsequence).
-export([longest_common_subsequence/2]).

longest_common_subsequence(X, Y) ->
    L1 = string:length(X),
    L2 = string:length(Y),
    Matrix = lists:duplicate(L1 + 1, lists:duplicate(L2 + 1, 0)),
    MatrixF = fill_matrix(X, Y, Matrix, L1, L2),
    MatrixF#matrix.cell[L1 + 1][L2 + 1].

fill_matrix(_, _, Matrix, 0, _L2) -> 
    Matrix;
fill_matrix(_, _, Matrix, _L1, 0) -> 
    Matrix;
fill_matrix(X, Y, Matrix, L1, L2) ->
    UpdatedMatrix = fill_matrix_row(X, Y, Matrix, L1, L2),
    fill_matrix(X, Y, UpdatedMatrix, L1 - 1, L2).

fill_matrix_row(_, _, Matrix, 0, _L2) -> 
    Matrix;
fill_matrix_row(X, Y, Matrix, L1, L2) ->
    NewRow = fill_matrix_cell(X, Y, Matrix, L1, L2),
    NewMatrix = Matrix#matrix{cell = lists:replace(Matrix#matrix.cell, L1, NewRow)},
    fill_matrix_row(X, Y, NewMatrix, L1 - 1, L2).

fill_matrix_cell(X, Y, Matrix, L1, L2) ->
    lists:map(fun(N) -> fill_matrix_cell_value(X, Y, Matrix, L1, N) end, lists:seq(0, L2)).

fill_matrix_cell_value(X, Y, Matrix, L1, L2) ->
    case (string:substr(X, L1, 1) == string:substr(Y, L2, 1)) of
        true -> 
            Matrix#matrix.cell[L1 - 1][L2 - 1] + 1;
        false -> 
            max(Matrix#matrix.cell[L1][L2 - 1], Matrix#matrix.cell[L1 - 1][L2])
    end.

max(A, B) -> 
    if A > B -> A; true -> B end.