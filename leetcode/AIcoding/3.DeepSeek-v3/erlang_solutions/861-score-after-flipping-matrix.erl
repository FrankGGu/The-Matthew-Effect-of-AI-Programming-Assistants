-spec matrix_score(Matrix :: [[integer()]]) -> integer().
matrix_score(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),

    % Flip rows to ensure the first column is all 1s
    FlippedRows = lists:map(fun(Row) ->
        case hd(Row) of
            0 -> lists:map(fun(X) -> 1 - X end, Row);
            1 -> Row
        end
    end, Matrix),

    % Flip columns to maximize the number of 1s in each column
    FlippedCols = lists:foldl(fun(Col, Acc) ->
        Count = lists:foldl(fun(Row, Sum) ->
            Sum + lists:nth(Col + 1, Row)
        end, 0, FlippedRows),
        if
            Count < Rows - Count ->
                lists:map(fun(Row) ->
                    lists:sublist(Row, Col) ++ [1 - lists:nth(Col + 1, Row)] ++ lists:nthtail(Col + 1, Row)
                end, Acc);
            true ->
                Acc
        end
    end, FlippedRows, lists:seq(1, Cols - 1)),

    % Calculate the total score
    lists:foldl(fun(Row, Sum) ->
        lists:foldl(fun(X, Acc) -> Acc * 2 + X end, 0, Row) + Sum
    end, 0, FlippedCols).