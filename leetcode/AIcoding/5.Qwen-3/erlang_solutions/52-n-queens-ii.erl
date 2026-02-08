-module(n_queens_ii).
-export([total_n_queens/1]).

total_n_queens(N) ->
    total_n_queens(N, 0, 0, 0, 0, 0).

total_n_queens(_, _, _, _, _, Count) when Count >= 16#7FFFFFFF ->
    Count;
total_n_queens(N, Row, Col, Diag1, Diag2, Count) when Row == N ->
    Count;
total_n_queens(N, Row, Col, Diag1, Diag2, Count) ->
    NewCount = case Col of
        _ when (Col band (Col - 1)) /= 0 -> Count;
        _ when (Diag1 band (1 bsl (Row + Col))) /= 0 -> Count;
        _ when (Diag2 band (1 bsl (Row - Col))) /= 0 -> Count;
        _ ->
            NewDiag1 = Diag1 bor (1 bsl (Row + Col)),
            NewDiag2 = Diag2 bor (1 bsl (Row - Col)),
            total_n_queens(N, Row + 1, 0, NewDiag1, NewDiag2, Count + 1)
    end,
    total_n_queens(N, Row, Col + 1, Diag1, Diag2, NewCount).