-module(solution).
-export([num_submatrices/1]).

num_submatrices(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Matrix)),
            Count = 0,
            for_rows(0, Rows - 1, Matrix, Cols, Count)
    end.

for_rows(Row, MaxRow, Matrix, Cols, Acc) when Row > MaxRow ->
    Acc;
for_rows(Row, MaxRow, Matrix, Cols, Acc) ->
    for_cols(Row, 0, Cols - 1, Matrix, Cols, Acc).

for_cols(_, Col, MaxCol, _, _, Acc) when Col > MaxCol ->
    Acc;
for_cols(Row, Col, MaxCol, Matrix, Cols, Acc) ->
    Count = count_from(Row, Col, Matrix, Cols),
    for_cols(Row, Col + 1, MaxCol, Matrix, Cols, Acc + Count).

count_from(Row, Col, Matrix, Cols) ->
    count_from(Row, Col, Matrix, Cols, 0).

count_from(Row, Col, Matrix, Cols, Acc) ->
    if
        Row >= length(Matrix) -> Acc;
        true ->
            case lists:nth(Row + 1, Matrix) of
                [] -> Acc;
                RowList ->
                    case lists:nth(Col + 1, RowList) of
                        1 -> count_from(Row + 1, Col, Matrix, Cols, Acc + 1);
                        _ -> Acc
                    end
            end
    end.