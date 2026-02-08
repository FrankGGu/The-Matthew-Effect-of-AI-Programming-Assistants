-spec is_valid_sudoku(Board :: [[char()]]) -> boolean().
is_valid_sudoku(Board) ->
    Rows = lists:duplicate(9, sets:new()),
    Cols = lists:duplicate(9, sets:new()),
    Boxes = lists:duplicate(9, sets:new()),
    check_rows(Board, Rows, Cols, Boxes, 0).

check_rows([], _, _, _, _) -> true;
check_rows([Row | Rest], Rows, Cols, Boxes, I) ->
    case check_cols(Row, Rows, Cols, Boxes, I, 0) of
        true -> check_rows(Rest, Rows, Cols, Boxes, I + 1);
        false -> false
    end.

check_cols([], Rows, Cols, Boxes, _, _) -> true;
check_cols([$. | Rest], Rows, Cols, Boxes, I, J) ->
    check_cols(Rest, Rows, Cols, Boxes, I, J + 1);
check_cols([Num | Rest], Rows, Cols, Boxes, I, J) ->
    RowSet = lists:nth(I + 1, Rows),
    ColSet = lists:nth(J + 1, Cols),
    BoxIndex = (I div 3) * 3 + (J div 3),
    BoxSet = lists:nth(BoxIndex + 1, Boxes),
    case sets:is_element(Num, RowSet) orelse sets:is_element(Num, ColSet) orelse sets:is_element(Num, BoxSet) of
        true -> false;
        false ->
            NewRows = setnth(I + 1, Rows, sets:add_element(Num, RowSet)),
            NewCols = setnth(J + 1, Cols, sets:add_element(Num, ColSet)),
            NewBoxes = setnth(BoxIndex + 1, Boxes, sets:add_element(Num, BoxSet)),
            check_cols(Rest, NewRows, NewCols, NewBoxes, I, J + 1)
    end.

setnth(1, [_ | T], X) -> [X | T];
setnth(N, [H | T], X) -> [H | setnth(N - 1, T, X)].