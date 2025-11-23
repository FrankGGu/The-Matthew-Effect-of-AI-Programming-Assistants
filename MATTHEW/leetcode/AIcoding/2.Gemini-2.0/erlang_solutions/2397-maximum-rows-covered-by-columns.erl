-module(maximum_rows_covered).
-export([maximum_rows_covered/3]).

maximum_rows_covered(Matrix, NumSelect, Cols) ->
    Len = length(Matrix),
    maximum_rows_covered(Matrix, NumSelect, Cols, 0, 0, 0, lists:seq(1, length(lists:nth(1,Matrix))), []).

maximum_rows_covered(Matrix, 0, _Cols, _Current, Max, _Count, _AvailableCols, _SelectedCols) ->
    Max;
maximum_rows_covered(Matrix, _NumSelect, _Cols, _Current, Max, _Count, [], _SelectedCols) ->
    Max;
maximum_rows_covered(Matrix, NumSelect, Cols, Current, Max, Count, [H|T], SelectedCols) ->
    NewSelectedCols = [H|SelectedCols],
    NewCount = count_covered_rows(Matrix, NewSelectedCols),
    NewMax = max(Max, NewCount),
    maximum_rows_covered(Matrix, NumSelect - 1, Cols, Current + 1, NewMax, NewCount, T, NewSelectedCols),
    maximum_rows_covered(Matrix, NumSelect, Cols, Current + 1, Max, Count, T, SelectedCols).

count_covered_rows(Matrix, SelectedCols) ->
    lists:foldl(fun(Row, Acc) ->
                        case is_row_covered(Row, SelectedCols) of
                            true -> Acc + 1;
                            false -> Acc
                        end
                end, 0, Matrix).

is_row_covered(Row, SelectedCols) ->
    lists:all(fun(Idx) ->
                      case lists:member(Idx, SelectedCols) of
                          true -> true;
                          false -> lists:nth(Idx, Row) == 0
                      end
              end, lists:seq(1, length(Row))).