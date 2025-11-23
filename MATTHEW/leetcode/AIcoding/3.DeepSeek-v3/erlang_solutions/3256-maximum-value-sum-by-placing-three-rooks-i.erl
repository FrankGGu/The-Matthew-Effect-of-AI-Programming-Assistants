-spec max_value_sum_by_placing_three_rooks_i(Chessboard :: [[integer()]]) -> integer().
max_value_sum_by_placing_three_rooks_i(Chessboard) ->
    Rows = length(Chessboard),
    Cols = length(hd(Chessboard)),
    Max = -1,
    find_max(Chessboard, Rows, Cols, Max).

find_max(Chessboard, Rows, Cols, Max) ->
    case Rows >= 3 of
        true ->
            NewMax = check_rows(Chessboard, Rows, Cols, Max),
            find_max(Chessboard, Rows - 1, Cols, NewMax);
        false ->
            case Cols >= 3 of
                true ->
                    NewMax = check_cols(Chessboard, Rows, Cols, Max),
                    find_max(Chessboard, Rows, Cols - 1, NewMax);
                false ->
                    Max
            end
    end.

check_rows(Chessboard, Rows, Cols, Max) ->
    lists:foldl(fun(Row, AccMax) ->
        case Row + 2 < Rows of
            true ->
                lists:foldl(fun(Col, InnerMax) ->
                    Sum = lists:sum([
                        lists:nth(Col + 1, lists:nth(Row + 1, Chessboard)),
                        lists:nth(Col + 1, lists:nth(Row + 2, Chessboard)),
                        lists:nth(Col + 1, lists:nth(Row + 3, Chessboard))
                    ]),
                    max(InnerMax, Sum)
                end, AccMax, lists:seq(0, Cols - 1));
            false ->
                AccMax
        end
    end, Max, lists:seq(0, Rows - 1)).

check_cols(Chessboard, Rows, Cols, Max) ->
    lists:foldl(fun(Col, AccMax) ->
        case Col + 2 < Cols of
            true ->
                lists:foldl(fun(Row, InnerMax) ->
                    Sum = lists:sum([
                        lists:nth(Col + 1, lists:nth(Row + 1, Chessboard)),
                        lists:nth(Col + 2, lists:nth(Row + 1, Chessboard)),
                        lists:nth(Col + 3, lists:nth(Row + 1, Chessboard))
                    ]),
                    max(InnerMax, Sum)
                end, AccMax, lists:seq(0, Rows - 1));
            false ->
                AccMax
        end
    end, Max, lists:seq(0, Cols - 1)).