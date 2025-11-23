-spec diagonal_sort(Mat :: [[integer()]]) -> [[integer()]].
diagonal_sort(Mat) ->
    M = length(Mat),
    case M of
        0 -> [];
        _ ->
            N = length(hd(Mat)),
            Diagonals = lists:foldl(
                fun(I, Acc) ->
                    Diagonal = lists:foldl(
                        fun(J, Acc1) ->
                            case I - J of
                                D when D >= 0, D < M, J >= 0, J < N ->
                                    [lists:nth(J + 1, lists:nth(D + 1, Mat)) | Acc1];
                                _ ->
                                    Acc1
                            end
                        end,
                        [],
                        lists:seq(0, N - 1)
                    ),
                    [lists:reverse(Diagonal) | Acc]
                end,
                [],
                lists:seq(0, M - 1)
            ),
            SortedDiagonals = lists:map(fun lists:sort/1, Diagonals),
            Reconstructed = lists:foldl(
                fun(I, Acc) ->
                    Row = lists:foldl(
                        fun(J, Acc1) ->
                            D = I - J,
                            case D >= 0 andalso D < M andalso J >= 0 andalso J < N of
                                true ->
                                    Diagonal = lists:nth(D + 1, SortedDiagonals),
                                    Elem = lists:nth(J + 1, Diagonal),
                                    [Elem | Acc1];
                                false ->
                                    Acc1
                            end
                        end,
                        [],
                        lists:seq(0, N - 1)
                    ),
                    [lists:reverse(Row) | Acc]
                end,
                [],
                lists:seq(0, M - 1)
            ),
            lists:reverse(Reconstructed)
    end.