-spec find_farmland(land :: [[integer()]]) -> [[integer()]].
find_farmland(Land) ->
    Rows = length(Land),
    Cols = case Rows of 0 -> 0; _ -> length(hd(Land)) end,
    find_farmland(Land, Rows, Cols, 0, []).

find_farmland(_, Rows, _, Row, Acc) when Row >= Rows -> lists:reverse(Acc);
find_farmland(Land, Rows, Cols, Row, Acc) ->
    {NewAcc, NewRow} = check_row(Land, Rows, Cols, Row, 0, Acc),
    find_farmland(Land, Rows, Cols, NewRow, NewAcc).

check_row(_, Rows, _, Row, _, Acc) when Row >= Rows -> {Acc, Row};
check_row(Land, Rows, Cols, Row, Col, Acc) ->
    case is_farmland_start(Land, Row, Col) of
        true ->
            {EndRow, EndCol} = find_farmland_end(Land, Rows, Cols, Row, Col),
            NewAcc = [[Row, Col, EndRow, EndCol] | Acc],
            mark_visited(Land, Row, Col, EndRow, EndCol),
            check_row(Land, Rows, Cols, Row, EndCol + 1, NewAcc);
        false ->
            check_row(Land, Rows, Cols, Row, Col + 1, Acc)
    end.

is_farmland_start(Land, Row, Col) ->
    try
        lists:nth(Col + 1, lists:nth(Row + 1, Land)) == 1
    catch
        _:_ -> false
    end.

find_farmland_end(Land, Rows, Cols, StartRow, StartCol) ->
    EndRow = find_end_row(Land, Rows, Cols, StartRow, StartCol),
    EndCol = find_end_col(Land, Rows, Cols, StartRow, StartCol, EndRow),
    {EndRow, EndCol}.

find_end_row(Land, Rows, Cols, Row, Col) ->
    if
        Row + 1 < Rows andalso is_farmland_start(Land, Row + 1, Col) ->
            find_end_row(Land, Rows, Cols, Row + 1, Col);
        true ->
            Row
    end.

find_end_col(Land, Rows, Cols, Row, Col, EndRow) ->
    if
        Col + 1 < Cols andalso is_farmland_col(Land, Row, EndRow, Col + 1) ->
            find_end_col(Land, Rows, Cols, Row, Col + 1, EndRow);
        true ->
            Col
    end.

is_farmland_col(Land, StartRow, EndRow, Col) ->
    lists:all(fun(R) ->
        try
            lists:nth(Col + 1, lists:nth(R + 1, Land)) == 1
        catch
            _:_ -> false
        end
    end, lists:seq(StartRow, EndRow)).

mark_visited(_, _, _, _, _) -> ok.