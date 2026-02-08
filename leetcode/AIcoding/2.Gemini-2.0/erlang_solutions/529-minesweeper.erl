-module(minesweeper).
-export([update_board/2]).

update_board(Board, [Row, Col]) ->
    update_board(Board, Row, Col, length(Board), length(lists:nth(1, Board))).

update_board(Board, Row, Col, Rows, Cols) ->
    case lists:nth(Row + 1, Board) of
        RowList ->
            case lists:nth(Col + 1, RowList) of
                "M" ->
                    replace_element(Board, Row, Col, "X");
                "E" ->
                    Count = count_adjacent_mines(Board, Row, Col, Rows, Cols),
                    if
                        Count > 0 ->
                            replace_element(Board, Row, Col, integer_to_list(Count));
                        true ->
                            UpdatedBoard = replace_element(Board, Row, Col, "B"),
                            update_adjacent_empty(UpdatedBoard, Row, Col, Rows, Cols)
                    end;
                _ ->
                    Board
            end
    end.

count_adjacent_mines(Board, Row, Col, Rows, Cols) ->
    Neighbors = get_neighbors(Row, Col, Rows, Cols),
    count_mines(Board, Neighbors, 0).

count_mines(_Board, [], Count) ->
    Count;
count_mines(Board, [[R, C] | Rest], Count) ->
    case lists:nth(R + 1, Board) of
        RowList ->
            case lists:nth(C + 1, RowList) of
                "M" ->
                    count_mines(Board, Rest, Count + 1);
                _ ->
                    count_mines(Board, Rest, Count)
            end
    end.

get_neighbors(Row, Col, Rows, Cols) ->
    Neighbors = [[Row - 1, Col - 1], [Row - 1, Col], [Row - 1, Col + 1],
                 [Row, Col - 1],                 [Row, Col + 1],
                 [Row + 1, Col - 1], [Row + 1, Col], [Row + 1, Col + 1]],
    filter_valid_neighbors(Neighbors, Rows, Cols, []).

filter_valid_neighbors([], _Rows, _Cols, Acc) ->
    lists:reverse(Acc);
filter_valid_neighbors([[R, C] | Rest], Rows, Cols, Acc) ->
    if
        R >= 0 and R < Rows and C >= 0 and C < Cols ->
            filter_valid_neighbors(Rest, Rows, Cols, [[R, C] | Acc]);
        true ->
            filter_valid_neighbors(Rest, Rows, Cols, Acc)
    end.

update_adjacent_empty(Board, Row, Col, Rows, Cols) ->
    Neighbors = get_neighbors(Row, Col, Rows, Cols),
    update_adjacent(Board, Neighbors, Rows, Cols).

update_adjacent(Board, [], _Rows, _Cols) ->
    Board;
update_adjacent(Board, [[R, C] | Rest], Rows, Cols) ->
    case lists:nth(R + 1, Board) of
        RowList ->
            case lists:nth(C + 1, RowList) of
                "E" ->
                    Count = count_adjacent_mines(Board, R, C, Rows, Cols),
                    if
                        Count > 0 ->
                            UpdatedBoard = replace_element(Board, R, C, integer_to_list(Count)),
                            update_adjacent(UpdatedBoard, Rest, Rows, Cols);
                        true ->
                            UpdatedBoard1 = replace_element(Board, R, C, "B"),
                            UpdatedBoard2 = update_adjacent_empty(UpdatedBoard1, R, C, Rows, Cols),
                            update_adjacent(UpdatedBoard2, Rest, Rows, Cols)
                    end;
                _ ->
                    update_adjacent(Board, Rest, Rows, Cols)
            end
    end.

replace_element(Board, Row, Col, Value) ->
    lists:map(fun(R, I) ->
                      if
                          I == Row + 1 ->
                              replace_element_in_row(R, Col, Value);
                          true ->
                              R
                      end
              end, Board, lists:seq(1, length(Board))).

replace_element_in_row(Row, Col, Value) ->
    lists:map(fun(C, I) ->
                      if
                          I == Col + 1 ->
                              Value;
                          true ->
                              C
                      end
              end, Row, lists:seq(1, length(Row))).