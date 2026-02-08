-module(find_all_farmland).
-export([find_farmland/1]).

find_farmland(Land) ->
    find_farmland_helper(Land, 0, 0, []).

find_farmland_helper(Land, Row, Col, Acc) ->
    Rows = length(Land),
    Cols = length(hd(Land)),

    if Row >= Rows then
        lists:reverse(Acc)
    else
        if Col >= Cols then
            find_farmland_helper(Land, Row + 1, 0, Acc)
        else
            if lists:nth(Col + 1, lists:nth(Row + 1, Land)) == 1 then
                {BottomRow, RightCol} = find_bottom_right(Land, Row, Col),
                NewLand = mark_visited(Land, Row, Col, BottomRow, RightCol),
                NewAcc = [[Row, Col, BottomRow, RightCol] | Acc],
                find_farmland_helper(NewLand, Row, RightCol + 1, NewAcc)
            else
                find_farmland_helper(Land, Row, Col + 1, Acc)
            end
        end
    end.

find_bottom_right(Land, Row, Col) ->
    Rows = length(Land),
    Cols = length(hd(Land)),
    find_bottom_right_helper(Land, Row, Col, Row, Col, Rows, Cols).

find_bottom_right_helper(Land, StartRow, StartCol, BottomRow, RightCol, Rows, Cols) ->
    NewBottomRow = find_bottom_row_index(Land, StartRow, StartCol, Rows),
    NewRightCol = find_right_col_index(Land, StartRow, StartCol, Cols),
    {NewBottomRow, NewRightCol}.

find_bottom_row_index(Land, StartRow, StartCol, Rows) ->
    find_bottom_row_index_helper(Land, StartRow, StartCol, StartRow, Rows).

find_bottom_row_index_helper(Land, StartRow, StartCol, CurrentRow, Rows) ->
    if CurrentRow >= Rows then
        CurrentRow - 1
    else
        if lists:nth(StartCol + 1, lists:nth(CurrentRow + 1, Land)) == 1 then
            find_bottom_row_index_helper(Land, StartRow, StartCol, CurrentRow + 1, Rows)
        else
            CurrentRow - 1
        end
    end.

find_right_col_index(Land, StartRow, StartCol, Cols) ->
    find_right_col_index_helper(Land, StartRow, StartCol, StartCol, Cols).

find_right_col_index_helper(Land, StartRow, StartCol, CurrentCol, Cols) ->
    if CurrentCol >= Cols then
        CurrentCol - 1
    else
        try
            if lists:nth(CurrentCol + 1, lists:nth(StartRow + 1, Land)) == 1 then
                find_right_col_index_helper(Land, StartRow, StartCol, CurrentCol + 1, Cols)
            else
                CurrentCol - 1
            end
        catch
            _:_ ->
                CurrentCol -1
        end
    end.

mark_visited(Land, StartRow, StartCol, BottomRow, RightCol) ->
    mark_visited_helper(Land, StartRow, StartCol, BottomRow, RightCol, []).

mark_visited_helper(Land, StartRow, StartCol, BottomRow, RightCol, Acc) ->
    if StartRow > BottomRow then
        Acc
    else
        NewRow = mark_visited_row(lists:nth(StartRow + 1, Land), StartCol, RightCol, []),
        NewLand = [lists:nth(I + 1, Land) || I <- lists:seq(0, StartRow -1)] ++ [NewRow] ++ [lists:nth(I + 1, Land) || I <- lists:seq(StartRow + 1, length(Land)-1)],
        mark_visited_helper(NewLand, StartRow + 1, StartCol, BottomRow, RightCol, NewLand).

mark_visited_row(Row, StartCol, RightCol, Acc) ->
    if StartCol > RightCol then
        Row
    else
        NewRow = [lists:nth(I + 1, Row) || I <- lists:seq(0, StartCol - 1)] ++ [0] ++ [lists:nth(I + 1, Row) || I <- lists:seq(RightCol + 1, length(Row) -1)],
        mark_visited_row(NewRow, RightCol + 1, RightCol, NewRow).