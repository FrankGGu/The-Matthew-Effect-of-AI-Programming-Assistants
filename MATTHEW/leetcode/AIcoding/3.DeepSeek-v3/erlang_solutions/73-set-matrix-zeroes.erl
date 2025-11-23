-spec set_zeroes(Matrix :: [[integer()]]) -> [[integer()]].
set_zeroes(Matrix) ->
    Rows = length(Matrix),
    Cols = case Rows of
        0 -> 0;
        _ -> length(hd(Matrix))
    end,
    RowFlags = lists:duplicate(Rows, false),
    ColFlags = lists:duplicate(Cols, false),
    {FinalRowFlags, FinalColFlags} = scan_matrix(Matrix, RowFlags, ColFlags, 0, 0),
    update_matrix(Matrix, FinalRowFlags, FinalColFlags, 0, 0).

scan_matrix(Matrix, RowFlags, ColFlags, Row, Col) when Row >= length(Matrix) ->
    {RowFlags, ColFlags};
scan_matrix(Matrix, RowFlags, ColFlags, Row, Col) when Col >= length(hd(Matrix)) ->
    scan_matrix(Matrix, RowFlags, ColFlags, Row + 1, 0);
scan_matrix(Matrix, RowFlags, ColFlags, Row, Col) ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) of
        0 ->
            NewRowFlags = set_flag(RowFlags, Row, true),
            NewColFlags = set_flag(ColFlags, Col, true),
            scan_matrix(Matrix, NewRowFlags, NewColFlags, Row, Col + 1);
        _ ->
            scan_matrix(Matrix, RowFlags, ColFlags, Row, Col + 1)
    end.

set_flag(Flags, Index, Value) ->
    lists:sublist(Flags, Index) ++ [Value] ++ lists:nthtail(Index + 1, Flags).

update_matrix(Matrix, RowFlags, ColFlags, Row, Col) when Row >= length(Matrix) ->
    Matrix;
update_matrix(Matrix, RowFlags, ColFlags, Row, Col) when Col >= length(hd(Matrix)) ->
    update_matrix(Matrix, RowFlags, ColFlags, Row + 1, 0);
update_matrix(Matrix, RowFlags, ColFlags, Row, Col) ->
    RowFlag = lists:nth(Row + 1, RowFlags),
    ColFlag = lists:nth(Col + 1, ColFlags),
    case RowFlag orelse ColFlag of
        true ->
            NewRow = lists:sublist(lists:nth(Row + 1, Matrix), Col) ++ [0] ++ lists:nthtail(Col + 1, lists:nth(Row + 1, Matrix))),
            NewMatrix = lists:sublist(Matrix, Row) ++ [NewRow] ++ lists:nthtail(Row + 1, Matrix),
            update_matrix(NewMatrix, RowFlags, ColFlags, Row, Col + 1);
        false ->
            update_matrix(Matrix, RowFlags, ColFlags, Row, Col + 1)
    end.