-module(solution).
-export([spiral_matrix/2]).

spiral_matrix(N, M) ->
    Matrix = lists:duplicate(N, lists:duplicate(M, -1)),
    spiral_fill(Matrix, 0, 0, N, M, 1).

spiral_fill(Matrix, R1, C1, R2, C2, Val) when R1 < R2, C1 < C2 ->
    Row = lists:sublist(Matrix, R1, 1),
    NewRow = lists:replace(Row, C1, Val),
    NewMatrix = lists:replace(Matrix, R1, NewRow),
    spiral_fill(NewMatrix, R1, C1 + 1, R2, C2, Val + 1);
spiral_fill(Matrix, R1, C1, R2, C2, Val) when R1 < R2, C1 < C2 ->
    NewRow = lists:nth(R1 + 1, Matrix),
    NewRow1 = lists:replace(NewRow, C2 - 1, Val),
    NewMatrix = lists:replace(Matrix, R1 + 1, NewRow1),
    spiral_fill(NewMatrix, R1, C1, R2, C2 - 1, Val + 1);
spiral_fill(Matrix, R1, C1, R2, C2, Val) when R1 < R2, C1 < C2 ->
    Row = lists:nth(R2 - 1, Matrix),
    NewRow = lists:replace(Row, C2 - 1, Val),
    NewMatrix = lists:replace(Matrix, R2 - 1, NewRow),
    spiral_fill(NewMatrix, R1, C1, R2 - 1, C2, Val + 1);
spiral_fill(Matrix, R1, C1, R2, C2, Val) when R1 < R2, C1 < C2 ->
    NewRow = lists:nth(R2 - 1, Matrix),
    NewRow1 = lists:replace(NewRow, C1, Val),
    NewMatrix = lists:replace(Matrix, R2 - 1, NewRow1),
    spiral_fill(NewMatrix, R1, C1 + 1, R2, C2, Val + 1);
spiral_fill(Matrix, _, _, _, _, _) ->
    Matrix.