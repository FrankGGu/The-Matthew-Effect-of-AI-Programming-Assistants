-module(find_valid_matrix).
-export([restoreMatrix/2]).

restoreMatrix(RowSum, ColSum) ->
    N = length(RowSum),
    M = length(ColSum),
    restoreMatrixHelper(RowSum, ColSum, N, M, []).

restoreMatrixHelper([], [], _, _, Acc) ->
    lists:reverse(Acc);
restoreMatrixHelper(RowSum, ColSum, N, M, Acc) ->
    restoreMatrixHelper(RowSum, ColSum, 0, 0, N, M, Acc, 0, 0).

restoreMatrixHelper(RowSum, ColSum, Row, Col, N, M, Acc, I, J) when I == N ->
    restoreMatrixHelper([], ColSum, N, M, Acc);
restoreMatrixHelper(RowSum, ColSum, Row, Col, N, M, Acc, I, J) when J == M ->
    restoreMatrixHelper(RowSum, ColSum, Row, Col, N, M, Acc, I + 1, 0);

restoreMatrixHelper([R | RestRow], [C | RestCol], Row, Col, N, M, Acc, I, J) ->
    Min = min(R, C),
    NewR = R - Min,
    NewC = C - Min,
    NewRowSum = [NewR | RestRow],
    NewColSum = [NewC | RestCol],

    case lists:nth(I + 1, Acc, []) of
        [] ->
            NewAcc = lists:nthtail(I, Acc) ++ [[Min]] ++ lists:nthtail(N - I - 1, Acc);
            restoreMatrixHelper(NewRowSum, NewColSum, Row, Col, N, M, NewAcc, I, J + 1);
        RowI ->
            NewRowI = RowI ++ [Min],
            NewAcc = lists:nthtail(I, Acc) ++ [NewRowI] ++ lists:nthtail(N - I - 1, Acc),
            restoreMatrixHelper(NewRowSum, NewColSum, Row, Col, N, M, NewAcc, I, J + 1)
    end.