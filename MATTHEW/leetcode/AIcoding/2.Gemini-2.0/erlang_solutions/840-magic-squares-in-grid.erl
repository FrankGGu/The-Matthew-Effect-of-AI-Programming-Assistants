-module(magic_squares_in_grid).
-export([num_magic_squares_inside/1]).

num_magic_squares_inside(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  num_magic_squares_inside(Grid, Rows, Cols, 0).

num_magic_squares_inside(_Grid, Rows, Cols, Count) when Rows < 3 or Cols < 3 ->
  Count;
num_magic_squares_inside(Grid, Rows, Cols, Count) ->
  NewCount = num_magic_squares_inside(Grid, Rows, Cols, 0, 0, Count),
  NewCount.

num_magic_squares_inside(_Grid, Rows, Cols, Row, Col, Count) when Row > Rows - 3 ->
  Count;
num_magic_squares_inside(_Grid, Rows, Cols, Row, Col, Count) when Col > Cols - 3 ->
  num_magic_squares_inside(_Grid, Rows, Cols, Row + 1, 0, Count);
num_magic_squares_inside(Grid, Rows, Cols, Row, Col, Count) ->
  Subgrid = get_subgrid(Grid, Row, Col),
  case is_magic_square(Subgrid) of
    true ->
      num_magic_squares_inside(Grid, Rows, Cols, Row, Col + 1, Count + 1);
    false ->
      num_magic_squares_inside(Grid, Rows, Cols, Row, Col + 1, Count)
  end.

get_subgrid(Grid, Row, Col) ->
  [lists:sublist(lists:nth(Row + I, Grid), Col + 1, 3) || I <- lists:seq(0, 2)].

is_magic_square(Grid) ->
  Values = lists:flatten(Grid),
  case lists:sort(Values) of
    [1,2,3,4,5,6,7,8,9] ->
      Sum = lists:sum(hd(Grid)),
      (lists:sum(lists:nth(2, Grid)) == Sum) and
      (lists:sum(lists:nth(3, Grid)) == Sum) and
      (lists:sum([lists:nth(1, lists:nth(I, Grid)) || I <- lists:seq(1, 3)]) == Sum) and
      (lists:sum([lists:nth(2, lists:nth(I, Grid)) || I <- lists:seq(1, 3)]) == Sum) and
      (lists:sum([lists:nth(3, lists:nth(I, Grid)) || I <- lists:seq(1, 3)]) == Sum) and
      (lists:nth(1, lists:nth(1, Grid)) + lists:nth(2, lists:nth(2, Grid)) + lists:nth(3, lists:nth(3, Grid)) == Sum) and
      (lists:nth(3, lists:nth(1, Grid)) + lists:nth(2, lists:nth(2, Grid)) + lists:nth(1, lists:nth(3, Grid)) == Sum);
    _ ->
      false
  end.