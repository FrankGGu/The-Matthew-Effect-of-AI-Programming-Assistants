-module(spiral_matrix_iv).
-export([spiralMatrix/2]).

spiralMatrix(M, N, Head) ->
    spiralMatrixHelper(M, N, Head, 0, 0, 0, []).

spiralMatrixHelper(M, N, Head, Row, Col, Dir, Acc) ->
    case Head of
        [] ->
            Result = lists:reverse(Acc),
            createMatrix(M, N, Result);
        [_|_] ->
            Value = hd(Head),
            Rest = tl(Head),
            case Dir of
                0 -> % Right
                    NewAcc = [Value | Acc],
                    if Col + 1 < N,
                        spiralMatrixHelper(M, N, Rest, Row, Col + 1, Dir, NewAcc),
                        spiralMatrixHelper(M, N, Rest, Row, Col, Dir + 1, NewAcc)
                    end;
                1 -> % Down
                    NewAcc = [Value | Acc],
                    if Row + 1 < M,
                        spiralMatrixHelper(M, N, Rest, Row + 1, Col, Dir, NewAcc),
                        spiralMatrixHelper(M, N, Rest, Row, Col, Dir + 1, NewAcc)
                    end;
                2 -> % Left
                    NewAcc = [Value | Acc],
                    if Col - 1 >= 0,
                        spiralMatrixHelper(M, N, Rest, Row, Col - 1, Dir, NewAcc),
                        spiralMatrixHelper(M, N, Rest, Row, Col, Dir + 1, NewAcc)
                    end;
                3 -> % Up
                    NewAcc = [Value | Acc],
                    if Row - 1 >= 0,
                        spiralMatrixHelper(M, N, Rest, Row - 1, Col, Dir, NewAcc),
                        spiralMatrixHelper(M, N, Rest, Row, Col, 0, NewAcc)
                    end
            end,
            NewRow = Row,
            NewCol = Col,
            NewDir = (Dir + 1) rem 4,
            NewAcc = [Value | Acc],
            case Dir of
                0 ->
                    if Col + 1 < N,
                        spiralMatrixHelper(M, N, Rest, NewRow, Col + 1, Dir, NewAcc),
                        createMatrix(M,N, lists:reverse([Value|Acc]))
                    end;
                1 ->
                    if Row + 1 < M,
                        spiralMatrixHelper(M, N, Rest, Row + 1, NewCol, Dir, NewAcc),
                        createMatrix(M,N, lists:reverse([Value|Acc]))
                    end;
                2 ->
                    if Col - 1 >= 0,
                        spiralMatrixHelper(M, N, Rest, NewRow, Col - 1, Dir, NewAcc),
                        createMatrix(M,N, lists:reverse([Value|Acc]))
                    end;
                3 ->
                    if Row - 1 >= 0,
                        spiralMatrixHelper(M, N, Rest, Row - 1, NewCol, Dir, NewAcc),
                        createMatrix(M,N, lists:reverse([Value|Acc]))
                    end
            end,
            spiralMatrixHelper(M, N, Rest, 0, 0, (Dir + 1) rem 4, [Value | Acc]);
        _ ->
            createMatrix(M, N, [])
    end.

createMatrix(M, N, List) ->
    createMatrixHelper(M, N, List, []).

createMatrixHelper(0, _, _, Acc) ->
    lists:reverse(Acc);
createMatrixHelper(M, N, List, Acc) ->
    {Row, Rest} = createRow(N, List, []),
    createMatrixHelper(M - 1, N, Rest, [Row | Acc]).

createRow(0, List, Acc) ->
    {lists:reverse(Acc), List};
createRow(N, [], Acc) ->
    Row = lists:duplicate(N, -1),
    {lists:reverse([Row ++ Acc]), []};
createRow(N, [H | T], Acc) ->
    createRow(N - 1, T, [H | Acc]).