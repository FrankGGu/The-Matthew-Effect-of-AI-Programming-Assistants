-module(champagne_tower).
-export([champagneTower/3]).

champagneTower(Poured, Query_row, Query_glass) ->
  N = Query_row + 1;
  Tower = array:new([N, N], {fixed, 0.0}),

  array:set(1, 1, float(Poured), Tower),

  pour(Tower, 1, N),

  min(1.0, array:get(Query_row + 1, Query_glass + 1, Tower)).

pour(Tower, Row, Max_row) ->
  if
    Row > Max_row ->
      ok;
    true ->
      for(Col = 1, Col =< Row, Col + 1,
        do
          Overflow = (array:get(Row, Col, Tower) - 1.0) / 2.0;
          if
            Overflow > 0 ->
              array:set(Row, Col, 1.0, Tower),
              update_next(Tower, Row, Col, Overflow);
            true ->
              ok
          end
        end),
      pour(Tower, Row + 1, Max_row)
  end.

update_next(Tower, Row, Col, Overflow) ->
  try
    Current_left = array:get(Row + 1, Col, Tower);
    array:set(Row + 1, Col, Current_left + Overflow, Tower)
  catch
    _:_ ->
      ok
  end,
  try
    Current_right = array:get(Row + 1, Col + 1, Tower);
    array:set(Row + 1, Col + 1, Current_right + Overflow, Tower)
  catch
    _:_ ->
      ok
  end.