-module(reshape_matrix).
-export([matrix_reshape/3]).

matrix_reshape(Mat, R, C) ->
  {Rows, Cols} = matrix_size(Mat),
  if Rows * Cols =/= R * C then
    Mat
  else
    List = matrix_to_list(Mat),
    list_to_matrix(List, R, C)
  end.

matrix_size(Mat) ->
  {length(Mat), length(hd(Mat))}.

matrix_to_list(Mat) ->
  lists:flatten(Mat).

list_to_matrix(List, R, C) ->
  list_to_matrix_helper(List, R, C, []).

list_to_matrix_helper([], 0, _, Acc) ->
  lists:reverse(Acc);
list_to_matrix_helper([], _, _, _) ->
  [];
list_to_matrix_helper(List, R, C, Acc) ->
  {Row, Rest} = lists:split(C, List),
  list_to_matrix_helper(Rest, R - 1, C, [Row | Acc]).