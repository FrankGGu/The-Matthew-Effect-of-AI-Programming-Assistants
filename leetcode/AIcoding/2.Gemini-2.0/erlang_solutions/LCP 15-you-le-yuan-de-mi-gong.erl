-module(solve).
-export([solve/1]).

solve(Maze) ->
  {Rows, Cols} = maze_size(Maze),
  Distances = array:new([Rows, Cols], infinity),
  array:set({0, 0}, 0, Distances),
  Q = queue:new(),
  Q1 = queue:in({0, 0}, Q),
  bfs(Maze, Q1, Distances, Rows, Cols).

bfs(Maze, Q, Distances, Rows, Cols) ->
  case queue:out(Q) of
    {empty, _} ->
      case array:get({Rows - 1, Cols - 1}, Distances) of
        infinity -> -1;
        Dist -> Dist
      end;
    {{Value, NewQ}, _} ->
      {Row, Col} = Value,
      Dist = array:get({Row, Col}, Distances),
      Neighbors = get_neighbors(Maze, Row, Col, Rows, Cols),
      UpdatedQ = process_neighbors(Maze, Neighbors, Dist, Distances, NewQ),
      bfs(Maze, UpdatedQ, Distances, Rows, Cols)
  end.

process_neighbors(Maze, Neighbors, Dist, Distances, Q) ->
  lists:foldl(
    fun({Row, Col}, AccQ) ->
      if array:get({Row, Col}, Distances) == infinity then
        array:set({Row, Col}, Dist + 1, Distances),
        queue:in({Row, Col}, AccQ)
      else
        AccQ
      end
    end,
    Q,
    Neighbors
  ).

get_neighbors(Maze, Row, Col, Rows, Cols) ->
  Neighbors = [],
  Neighbors1 =
    if Row > 0 andalso lists:nth(Col + 1, lists:nth(Row, Maze)) == 1 then
      [{Row - 1, Col} | Neighbors]
    else
      Neighbors
    end,
  Neighbors2 =
    if Row < Rows - 1 andalso lists:nth(Col + 1, lists:nth(Row + 2, Maze)) == 1 then
      [{Row + 1, Col} | Neighbors1]
    else
      Neighbors1
    end,
  Neighbors3 =
    if Col > 0 andalso lists:nth(Col, lists:nth(Row + 1, Maze)) == 1 then
      [{Row, Col - 1} | Neighbors2]
    else
      Neighbors2
    end,
  if Col < Cols - 1 andalso lists:nth(Col + 2, lists:nth(Row + 1, Maze)) == 1 then
    [{Row, Col + 1} | Neighbors3]
  else
    Neighbors3
  end.

maze_size(Maze) ->
  Rows = length(Maze),
  Cols = length(hd(Maze)),
  {Rows, Cols}.