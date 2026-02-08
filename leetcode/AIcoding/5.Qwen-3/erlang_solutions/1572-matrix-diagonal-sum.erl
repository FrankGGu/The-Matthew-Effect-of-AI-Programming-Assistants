-module(matrix_diagonal_sum).
-export([diagonalSum/1]).

diagonalSum(Matrix) ->
    Rows = length(Matrix),
    Sum = 0,
    loop(0, Rows - 1, Matrix, Sum).

loop(I, N, Matrix, Acc) when I > N ->
    Acc;
loop(I, N, Matrix, Acc) ->
    Row = lists:nth(I + 1, Matrix),
    Val1 = lists:nth(I + 1, Row),
    Val2 = lists:nth(N - I + 1, Row),
    NewAcc = Acc + Val1 + Val2,
    loop(I + 1, N, Matrix, NewAcc).