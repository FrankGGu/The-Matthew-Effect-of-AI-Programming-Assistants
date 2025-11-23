-module(maximum_number_of_fish).
-export([max_fish/1]).

max_fish(Grid) ->
  {Rows, Cols} = grid_size(Grid),
  Visited = list_to_tuple([false || _ <- lists:seq(1, Rows * Cols)]),
  max_fish_helper(Grid, Rows, Cols, Visited, 0).

max_fish_helper(_Grid, _Rows, _Cols, _Visited, MaxFish) ->
  case find_unvisited_cell(_Grid, _Rows, _Cols, _Visited) of
    none -> MaxFish;
    {Row, Col} ->
      Fish = dfs(_Grid, _Rows, _Cols, Row, Col, Visited, 0),
      NewMaxFish = max(MaxFish, Fish),
      max_fish_helper(_Grid, _Rows, _Cols, _Visited, NewMaxFish)
  end.

dfs(Grid, Rows, Cols, Row, Col, Visited, Fish) ->
  if Row < 1 orelse Row > Rows orelse Col < 1 orelse Col > Cols then
    0
  else
    Index = (Row - 1) * Cols + Col,
    case element(Index, Visited) of
      true -> 0;
      false ->
        FishValue = element(Col, element(Row, Grid)),
        if FishValue == 0 then
          0
        else
          NewVisited = setelement(Index, Visited, true),
          FishValue + dfs(Grid, Rows, Cols, Row + 1, Col, NewVisited, 0) +
            dfs(Grid, Rows, Cols, Row - 1, Col, NewVisited, 0) +
            dfs(Grid, Rows, Cols, Row, Col + 1, NewVisited, 0) +
            dfs(Grid, Rows, Cols, Row, Col - 1, NewVisited, 0)
        end
    end
  end.

find_unvisited_cell(Grid, Rows, Cols, Visited) ->
  find_unvisited_cell_helper(Grid, Rows, Cols, Visited, 1).

find_unvisited_cell_helper(_Grid, _Rows, _Cols, _Visited, Index) when Index > _Rows * _Cols ->
  none;
find_unvisited_cell_helper(_Grid, Rows, Cols, Visited, Index) ->
  case element(Index, Visited) of
    true ->
      find_unvisited_cell_helper(_Grid, Rows, Cols, Visited, Index + 1);
    false ->
      Row = (Index - 1) div Cols + 1,
      Col = (Index - 1) rem Cols + 1,
      {Row, Col}
  end.

grid_size(Grid) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  {Rows, Cols}.