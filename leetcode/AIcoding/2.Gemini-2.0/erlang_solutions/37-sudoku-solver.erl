-module(sudoku_solver).
-export([solveSudoku/1]).

solveSudoku(Board) ->
  Board1 = lists:map(fun(Row) -> lists:map(fun(C) -> if C == '.' -> 0; true -> list_to_integer([C]) end, Row) end, Board),
  {ok, SolvedBoard} = solve(Board1, 0, 0),
  lists:map(fun(Row) -> lists:map(fun(C) -> integer_to_list(C) end, Row) end, SolvedBoard).

solve(Board, Row, Col) ->
  case find_empty_cell(Board) of
    none -> {ok, Board};
    {R, C} ->
      try_values(Board, R, C)
  end.

try_values(Board, Row, Col) ->
  lists:foldl(fun(Value, Acc) ->
                  case Acc of
                    {ok, _} ->
                      Acc;
                    error ->
                      case is_valid(Board, Row, Col, Value) of
                        true ->
                          NewBoard = set_value(Board, Row, Col, Value),
                          case solve(NewBoard, Row, Col) of
                            {ok, SolvedBoard} ->
                              {ok, SolvedBoard};
                            error ->
                              error
                          end;
                        false ->
                          error
                      end
                  end
              end, error, lists:seq(1, 9)).

find_empty_cell(Board) ->
  find_empty_cell_helper(Board, 0, 0).

find_empty_cell_helper(Board, Row, Col) ->
  case Row of
    9 ->
      none;
    _ ->
      case Col of
        9 ->
          find_empty_cell_helper(Board, Row + 1, 0);
        _ ->
          case lists:nth(Row + 1, Board) of
            R ->
              case lists:nth(Col + 1, R) of
                0 ->
                  {Row, Col};
                _ ->
                  find_empty_cell_helper(Board, Row, Col + 1)
              end
          end
      end
  end.

is_valid(Board, Row, Col, Value) ->
  not (row_contains(Board, Row, Value) or
       col_contains(Board, Col, Value) or
       box_contains(Board, Row, Col, Value)).

row_contains(Board, Row, Value) ->
  lists:member(Value, lists:nth(Row + 1, Board)).

col_contains(Board, Col, Value) ->
  lists:any(fun(Row) -> lists:nth(Col + 1, Row) == Value end, Board).

box_contains(Board, Row, Col, Value) ->
  BoxRowStart = Row - (Row rem 3),
  BoxColStart = Col - (Col rem 3),
  lists:any(fun(R) ->
                lists:any(fun(C) ->
                              lists:nth(C + 1, lists:nth(R + 1, Board)) == Value
                          end, lists:seq(BoxColStart, BoxColStart + 2))
            end, lists:seq(BoxRowStart, BoxRowStart + 2)).

set_value(Board, Row, Col, Value) ->
  lists:map(fun(R, I) ->
                case I of
                  Row + 1 ->
                    lists:map(fun(C, J) ->
                                  case J of
                                    Col + 1 ->
                                      Value;
                                    _ ->
                                      C
                                  end
                              end, R, lists:seq(1, 9));
                  _ ->
                    R
                end
            end, Board, lists:seq(1, 9)).