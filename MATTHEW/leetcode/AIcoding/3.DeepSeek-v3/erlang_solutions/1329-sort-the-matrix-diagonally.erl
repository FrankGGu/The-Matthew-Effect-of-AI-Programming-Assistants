-spec diagonal_sort(Mat :: [[integer()]]) -> [[integer()]].
diagonal_sort(Mat) ->
    M = length(Mat),
    case M of
        0 -> Mat;
        _ ->
            N = length(hd(Mat)),
            Diagonals = lists:foldl(
                fun(I, Acc) ->
                    Diagonal = lists:map(
                        fun(J) ->
                            lists:nth(J + 1, lists:nth(I + J + 1, Mat))
                        end,
                        lists:seq(0, min(M - I - 1, N - 1) - 1
                    ),
                    Sorted = lists:sort(Diagonal),
                    [{I, Sorted} | Acc]
                end,
                [],
                lists:seq(0, M - 1)
            ++ lists:foldl(
                fun(J, Acc) ->
                    Diagonal = lists:map(
                        fun(I) ->
                            lists:nth(J + 1, lists:nth(I + 1, Mat))
                        end,
                        lists:seq(0, min(M - 1, N - J - 1)) - 1
                    ),
                    Sorted = lists:sort(Diagonal),
                    [{J + M, Sorted} | Acc]
                end,
                [],
                lists:seq(1, N - 1)),
            lists:foldl(
                fun({Key, Sorted}, AccMat) ->
                    if
                        Key < M ->
                            I = Key,
                            lists:foldl(
                                fun({J, Val}, RowAcc) ->
                                    Row = lists:nth(I + J + 1, RowAcc),
                                    NewRow = lists:sublist(Row, J) ++ [Val] ++ lists:nthtail(J + 1, Row),
                                    lists:sublist(RowAcc, I + J) ++ [NewRow] ++ lists:nthtail(I + J + 1, RowAcc)
                                end,
                                AccMat,
                                lists:zip(lists:seq(0, length(Sorted) - 1), Sorted));
                        true ->
                            J = Key - M,
                            lists:foldl(
                                fun({I, Val}, RowAcc) ->
                                    Row = lists:nth(I + 1, RowAcc),
                                    NewRow = lists:sublist(Row, J) ++ [Val] ++ lists:nthtail(J + 1, Row),
                                    lists:sublist(RowAcc, I) ++ [NewRow] ++ lists:nthtail(I + 1, RowAcc)
                                end,
                                AccMat,
                                lists:zip(lists:seq(0, length(Sorted) - 1), Sorted))
                    end
                end,
                Mat,
                Diagonals)
    end.