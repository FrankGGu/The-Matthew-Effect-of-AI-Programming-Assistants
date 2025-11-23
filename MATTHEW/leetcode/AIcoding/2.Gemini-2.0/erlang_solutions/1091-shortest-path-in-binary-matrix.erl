-module(shortest_path_binary_matrix).
-export([shortest_path/1]).

shortest_path(Grid) ->
  N = length(Grid),
  if N =:= 0 then
    -1
  else
    if element(1, element(1, Grid)) =:= 1 then
      -1
    else
      queue_bfs(Grid, [{1, 1}], [{1, 1}], N, 1)
    end
  end.

queue_bfs(Grid, Queue, Visited, N, Distance) ->
  case Queue of
    [] ->
      -1;
    [{Row, Col} | Rest] ->
      if Row =:= N andalso Col =:= N then
        Distance
      else
        Neighbors = get_neighbors(Row, Col, Grid, N, Visited),
        NewQueue = Rest ++ Neighbors,
        NewVisited = Visited ++ Neighbors,
        queue_bfs(Grid, NewQueue, NewVisited, N, Distance + 1)
      end
  end.

get_neighbors(Row, Col, Grid, N, Visited) ->
  Neighbors = [
    {Row - 1, Col - 1},
    {Row - 1, Col},
    {Row - 1, Col + 1},
    {Row, Col - 1},
    {Row, Col + 1},
    {Row + 1, Col - 1},
    {Row + 1, Col},
    {Row + 1, Col + 1}
  ],
  lists:filter(
    fun({R, C}) ->
      R >= 1 andalso R =< N andalso C >= 1 andalso C =< N andalso
        element(C, element(R, Grid)) =:= 0 andalso
        not lists:member({R, C}, Visited)
    end,
    Neighbors
  ).