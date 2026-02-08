-module(minimum_diameter).
-export([solve/1]).

solve(Edges) ->
  graph_from_edges(Edges, Graph),
  Vertices = maps:keys(Graph),
  {Diameter1, Center1} = find_diameter(Graph, Vertices),
  {Diameter2, Center2} = find_diameter(Graph, Vertices),

  lists:min([
    Diameter1 + Diameter2 + 1 + dist(Graph, C1, C2)
    || C1 <- Center1,
       C2 <- Center2
  ]).

graph_from_edges(Edges, Graph) ->
  lists:foldl(
    fun([U, V], Acc) ->
      Acc1 = maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
      maps:update_with(V, fun(List) -> [U | List] end, [U], Acc1)
    end,
    #{},
    Edges
  ).

find_diameter(Graph, Vertices) ->
  {Diameter, Centers} =
    lists:foldl(
      fun(V, {AccDiameter, AccCenters}) ->
        {MaxDist, Farthest} = bfs(Graph, V),
        {MaxDist2, _} = bfs(Graph, Farthest),
        if
          MaxDist2 > AccDiameter ->
            {MaxDist2, [Farthest]},
          MaxDist2 == AccDiameter ->
            {AccDiameter, [Farthest | AccCenters]},
          true ->
            {AccDiameter, AccCenters}
        end
      end,
      {0, []},
      Vertices
    ),
  {Diameter, find_centers(Graph, Centers)}.

find_centers(Graph, FarthestNodes) ->
  MaxDist = bfs_distance(Graph, lists:nth(1, FarthestNodes)),
  lists:filter(
    fun(Node) ->
      bfs_distance(Graph, Node) == MaxDist
    end,
    FarthestNodes
  ).

bfs_distance(Graph, Start) ->
  {_, Farthest} = bfs(Graph, Start),
  Farthest.

bfs(Graph, Start) ->
  bfs(Graph, [Start], #{Start => 0}, {0, Start}).

bfs(Graph, [], _, {MaxDist, Farthest}) ->
  {MaxDist, Farthest};
bfs(Graph, [V | Queue], Visited, {MaxDist, Farthest}) ->
  Neighbors = maps:get(V, Graph, []),
  UnvisitedNeighbors = lists:filter(
    fun(Neighbor) ->
      not maps:is_key(Neighbor, Visited)
    end,
    Neighbors
  ),
  NewVisited = lists:foldl(
    fun(Neighbor, Acc) ->
      maps:put(Neighbor, maps:get(V, Visited) + 1, Acc)
    end,
    Visited,
    UnvisitedNeighbors
  ),
  NewQueue = Queue ++ UnvisitedNeighbors,
  NewMaxDist = lists:foldl(
    fun(Neighbor, {AccMaxDist, AccFarthest}) ->
      Dist = maps:get(Neighbor, NewVisited),
      if
        Dist > AccMaxDist ->
          {Dist, Neighbor},
        true ->
          {AccMaxDist, AccFarthest}
      end
    end,
    {MaxDist, Farthest},
    UnvisitedNeighbors
  ),
  bfs(Graph, NewQueue, NewVisited, NewMaxDist).

dist(Graph, Start, End) ->
  dist(Graph, [Start], #{Start => 0}, End).

dist(Graph, [], _, _) ->
  infinity;
dist(Graph, [V | Queue], Visited, End) ->
  if
    V == End ->
      maps:get(V, Visited);
    true ->
      Neighbors = maps:get(V, Graph, []),
      UnvisitedNeighbors = lists:filter(
        fun(Neighbor) ->
          not maps:is_key(Neighbor, Visited)
        end,
        Neighbors
      ),
      NewVisited = lists:foldl(
        fun(Neighbor, Acc) ->
          maps:put(Neighbor, maps:get(V, Visited) + 1, Acc)
        end,
        Visited,
        UnvisitedNeighbors
      ),
      NewQueue = Queue ++ UnvisitedNeighbors,
      dist(Graph, NewQueue, NewVisited, End)
  end.

infinity ->
  1000000000.