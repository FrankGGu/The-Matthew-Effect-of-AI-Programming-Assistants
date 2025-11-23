-module(search_matrix).
-export([search_matrix/2]).

search_matrix(Matrix, Target) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  search_matrix_helper(Matrix, Rows, Cols, Target).

search_matrix_helper(_Matrix, 0, _Cols, _Target) ->
  false;
search_matrix_helper(_Matrix, _Rows, 0, _Target) ->
  false;
search_matrix_helper(Matrix, Rows, Cols, Target) ->
  search_matrix_recursive(Matrix, 0, Rows - 1, Cols, Target).

search_matrix_recursive(_Matrix, Low, High, _Cols, _Target) when Low > High ->
  false;
search_matrix_recursive(Matrix, Low, High, Cols, Target) ->
  Mid = (Low + High) div 2,
  Row = lists:nth(Mid + 1, Matrix),
  if Target >= lists:nth(1, Row) and Target =< lists:nth(Cols, Row) ->
    search_row(Row, Target),
  Target < lists:nth(1, Row) ->
    search_matrix_recursive(Matrix, Low, Mid - 1, Cols, Target);
  Target > lists:nth(Cols, Row) ->
    search_matrix_recursive(Matrix, Mid + 1, High, Cols, Target)
  end.

search_row([], _Target) ->
  false;
search_row([H|T], Target) ->
  if H == Target ->
    true;
  true ->
    search_row(T, Target)
  end.