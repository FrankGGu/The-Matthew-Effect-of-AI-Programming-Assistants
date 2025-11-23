-module(solution).
-export([count_squares/1]).

count_squares(Matrix) ->
    Rows = length(Matrix),
    Cols = case Rows of
        0 -> 0;
        _ -> length(hd(Matrix))
    end,
    CountMatrix = lists:map(fun(Row) -> lists:map(fun(_) -> 0 end, Row) end, Matrix),
    count_squares_helper(Matrix, CountMatrix, Rows, Cols, 0).

count_squares_helper(_, CountMatrix, 0, _, Acc) -> Acc;
count_squares_helper(Matrix, CountMatrix, Rows, Cols, Acc) ->
    NewAcc = count_row(Matrix, CountMatrix, Rows, Cols, 1, Acc),
    count_squares_helper(Matrix, CountMatrix, Rows, Cols - 1, NewAcc).

count_row(_, _, 0, _, _, Acc) -> Acc;
count_row(Matrix, CountMatrix, Rows, Cols, R, Acc) ->
    NewAcc = count_col(Matrix, CountMatrix, Rows, Cols, R, 1, Acc),
    count_row(Matrix, CountMatrix, Rows, Cols, R - 1, NewAcc).

count_col(Matrix, CountMatrix, Rows, Cols, R, C, Acc) ->
    case C > Cols of
        true -> Acc;
        false ->
            case lists:nth(C, lists:nth(R, Matrix)) of
                1 ->
                    Count = if
                        R == 1 orelse C == 1 -> 1;
                        true -> min(min(lists:nth(R, CountMatrix) + 1, lists:nth(R - 1, CountMatrix) + 1), lists:nth(R, CountMatrix, C - 1) + 1)
                    end,
                    NewCountMatrix = lists:replace(CountMatrix, R, lists:replace(lists:nth(R, CountMatrix), C, Count)),
                    count_col(Matrix, NewCountMatrix, Rows, Cols, R, C + 1, Acc + Count);
                _ -> count_col(Matrix, CountMatrix, Rows, Cols, R, C + 1, Acc)
            end
    end.