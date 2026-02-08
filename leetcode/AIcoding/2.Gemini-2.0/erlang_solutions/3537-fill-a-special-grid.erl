-module(fill_special_grid).
-export([fill_grid/1]).

fill_grid(N) ->
  fill_grid_helper(N, 1, 1, []).

fill_grid_helper(0, _, _, Acc) ->
  lists:reverse(Acc);
fill_grid_helper(N, Row, Col, Acc) ->
  Value = get_value(Row, Col),
  NewAcc = [{Row, Col, Value} | Acc],
  if
    Col =:= N ->
      fill_grid_helper(N, Row + 1, 1, NewAcc);
    true ->
      fill_grid_helper(N, Row, Col + 1, NewAcc)
  end.

get_value(Row, Col) ->
  RowXorCol = Row bxor Col,
  if
    RowXorCol rem 2 =:= 0 ->
      1;
    true ->
      0
  end.