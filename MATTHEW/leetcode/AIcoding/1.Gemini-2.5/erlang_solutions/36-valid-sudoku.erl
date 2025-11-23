-module(solution).
-export([is_valid_sudoku/1]).

is_valid_sudoku(Board) ->
    InitialRows = array:new([{size, 9}, {fixed, true}, {default, gb_sets:new()}]),
    InitialCols = array:new([{size, 9}, {fixed, true}, {default, gb_sets:new()}]),
    InitialBoxes = array:new([{size, 9}, {fixed, true}, {default, gb_sets:new()}]),
    check_rows(0, Board, InitialRows, InitialCols, InitialBoxes).

check_rows(9, _, Rows, Cols, Boxes) ->
    true;
check_rows(Row, [CurrentRowList | RestBoard], Rows, Cols, Boxes) ->
    case check_cols(Row, 0, CurrentRowList, Rows, Cols, Boxes) of
        false -> false;
        {ok, NewRows, NewCols, NewBoxes} ->
            check_rows(Row + 1, RestBoard, NewRows, NewCols, NewBoxes)
    end.

check_cols(Row, 9, _, Rows, Cols, Boxes) ->
    {ok, Rows, Cols, Boxes};
check_cols(Row, Col, [Char | RestRowList], Rows, Cols, Boxes) ->
    case Char of
        $. ->
            check_cols(Row, Col + 1, RestRowList, Rows, Cols, Boxes);
        _ ->
            Num = Char - $0,

            CurrentRowSet = array:get(Row, Rows),
            if gb_sets:is_member(Num, CurrentRowSet) ->
                false;
            true ->
                NewRows = array:set(Row, gb_sets:add(Num, CurrentRowSet), Rows),

                CurrentColSet = array:get(Col, Cols),
                if gb_sets:is_member(Num, CurrentColSet) ->
                    false;
                true ->
                    NewCols = array:set(Col, gb_sets:add(Num, CurrentColSet), Cols),

                    BoxIndex = (Row div 3) * 3 + (Col div 3),
                    CurrentBoxSet = array:get(BoxIndex, Boxes),
                    if gb_sets:is_member(Num, CurrentBoxSet) ->
                        false;
                    true ->
                        NewBoxes = array:set(BoxIndex, gb_sets:add(Num, CurrentBoxSet), Boxes),
                        check_cols(Row, Col + 1, RestRowList, NewRows, NewCols, NewBoxes)
                    end
                end
            end
    end.