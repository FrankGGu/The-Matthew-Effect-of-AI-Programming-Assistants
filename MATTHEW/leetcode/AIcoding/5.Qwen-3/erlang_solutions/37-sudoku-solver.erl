-module(sudoku_solver).
-export([solve_sudoku/1]).

solve_sudoku(Board) ->
    solve(Board, 0, 0).

solve(Board, Row, Col) ->
    case next_cell(Row, Col) of
        {error, _} -> Board;
        {NextRow, NextCol} ->
            case get_value(Board, Row, Col) of
                empty ->
                    lists:foreach(fun(Num) ->
                                          if
                                              is_valid(Board, Row, Col, Num) ->
                                                  set_value(Board, Row, Col, Num),
                                                  case solve(Board, NextRow, NextCol) of
                                                      false -> set_value(Board, Row, Col, empty);
                                                      Result -> Result
                                                  end;
                                              true -> false
                                          end
                                      end, [1,2,3,4,5,6,7,8,9]),
                    false;
                _ -> solve(Board, NextRow, NextCol)
            end
    end.

next_cell(Row, Col) ->
    case Col + 1 of
        9 -> case Row + 1 of
                 9 -> {error, done};
                 R -> {R, 0}
             end;
        C -> {Row, C}
    end.

get_value(Board, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Board)).

set_value(Board, Row, Col, Value) ->
    RowList = lists:nth(Row + 1, Board),
    NewRow = lists:sublist(RowList, Col) ++ [Value] ++ lists:nthtail(Col + 1, RowList),
    lists:sublist(Board, Row + 1) ++ [NewRow] ++ lists:nthtail(Row + 2, Board).

is_valid(Board, Row, Col, Num) ->
    RowValid = not lists:member(Num, lists:nth(Row + 1, Board)),
    ColValid = not lists:member(Num, lists:map(fun(RowList) -> lists:nth(Col + 1, RowList) end, Board)),
    BoxRow = (Row div 3) * 3,
    BoxCol = (Col div 3) * 3,
    BoxValid = not lists:member(Num, lists:flatten([lists:sublist(lists:nth(I + 1, Board), BoxCol + 1, 3) || I <- lists:seq(BoxRow, BoxRow + 2)])),
    RowValid and ColValid and BoxValid.