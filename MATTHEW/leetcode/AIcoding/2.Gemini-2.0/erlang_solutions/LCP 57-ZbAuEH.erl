-module(solution).
-export([max_whack]).

max_whack(grid) ->
  max_whack(grid, 0, 0, 0).

max_whack(grid, Row, Col, Sum) ->
  case grid of
    [] ->
      Sum;
    [RowList | RestGrid] ->
      max_whack_row(RowList, Row, Col, Sum, RestGrid)
  end.

max_whack_row([], _Row, _Col, Sum, RestGrid) ->
  max_whack(RestGrid, 0, 0, Sum);
max_whack_row([Value | RestRow], Row, Col, Sum, RestGrid) ->
  NewSum = Sum + Value,
  max_whack_row(RestRow, Row, Col + 1, NewSum, RestGrid).