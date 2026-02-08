-module(jewels).
-export([maxValue/1]).

maxValue(grid) ->
  {Rows, Cols} = grid_size(grid),
  dp(grid, Rows - 1, Cols - 1, Rows, Cols, []).

dp(Grid, Row, Col, Rows, Cols, Cache) ->
  case lookup(Cache, {Row, Col}) of
    {value, Val} ->
      Val;
    undefined ->
      case {Row, Col} of
        {0, 0} ->
          Value = element(Col + 1, element(Row + 1, Grid)),
          put_cache({Row, Col}, Value, Cache);
        {0, _} ->
          Value = element(Col + 1, element(Row + 1, Grid)) + dp(Grid, Row, Col - 1, Rows, Cols, Cache),
          put_cache({Row, Col}, Value, Cache);
        {_, 0} ->
          Value = element(Col + 1, element(Row + 1, Grid)) + dp(Grid, Row - 1, Col, Rows, Cols, Cache),
          put_cache({Row, Col}, Value, Cache);
        {_, _} ->
          Value = element(Col + 1, element(Row + 1, Grid)) + max(dp(Grid, Row - 1, Col, Rows, Cols, Cache), dp(Grid, Row, Col - 1, Rows, Cols, Cache)),
          put_cache({Row, Col}, Value, Cache)
      end
  end.

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(element(1, Grid)),
  {Rows, Cols}.

lookup(Cache, {Row, Col}) ->
    lists:keyfind({Row,Col}, 1, Cache).

put_cache({Row, Col}, Value, Cache) ->
  [{ {Row, Col}, Value} | Cache].