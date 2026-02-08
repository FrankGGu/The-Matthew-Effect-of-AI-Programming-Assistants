-module(largest_1_bordered_square).
-export([largest_kite/1]).

largest_kite(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxSize = 0,
    lists:foldl(fun(RowIndex, Acc) ->
                        lists:foldl(fun(ColIndex, Acc2) ->
                                            if
                                                element(RowIndex+1, Grid) == 1 andalso element(ColIndex+1, Grid) == 1 ->
                                                    Size = find_max_size(Grid, RowIndex, ColIndex, Rows, Cols),
                                                    max(Acc2, Size);
                                                true ->
                                                    Acc2
                                            end
                                    end, Acc, lists:seq(0, Cols-1))
                end, MaxSize, lists:seq(0, Rows-1)).

find_max_size(Grid, Row, Col, Rows, Cols) ->
    MaxPossible = min(Rows - Row, Cols - Col),
    lists:foldl(fun(Size, Acc) ->
                        if
                            check_border(Grid, Row, Col, Size) ->
                                Size;
                            true ->
                                Acc
                        end
                    end, 0, lists:seq(1, MaxPossible)).

check_border(Grid, Row, Col, Size) ->
    R = Row + Size - 1,
    C = Col + Size - 1,
    IsTopBottom = is_same_line(Grid, Row, Col, C, 1),
    IsLeftRight = is_same_line(Grid, Row, Col, R, 0),
    IsTopBottom andalso IsLeftRight.

is_same_line(Grid, StartRow, StartCol, End, Direction) ->
    lists:all(fun(I) ->
                  if
                      Direction == 0 ->
                          element(StartRow + I + 1, Grid) == 1 andalso element(StartCol + 1, Grid) == 1;
                      true ->
                          element(StartRow + 1, Grid) == 1 andalso element(StartCol + I + 1, Grid) == 1
                  end
              end, lists:seq(0, End - 1)).