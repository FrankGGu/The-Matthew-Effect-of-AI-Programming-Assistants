-module(max_points).
-export([maximum_points/2]).

maximum_points(Edges, Capacity) ->
  graph_from_edges(Edges, Graph),
  dfs(1, Graph, Capacity, #{1 => true}, 1).

graph_from_edges(Edges, Acc) ->
  lists:foldl(
    fun([U, V], Graph) ->
      Graph1 = maps:update_with(U, fun(Neighbors) -> [V | Neighbors] end, [V], Graph),
      maps:update_with(V, fun(Neighbors) -> [U | Neighbors] end, [U], Graph1)
    end,
    #{},
    Edges
  ).

dfs(Node, Graph, Capacity, Visited, Points) ->
  Neighbors = maps:get(Node, Graph, []),
  MaxPoints = lists:foldl(
    fun(Neighbor, Acc) ->
      case maps:get(Neighbor, Visited, false) of
        true ->
          Acc;
        false ->
          case Capacity rem Neighbor == 0 of
            true ->
              NewVisited = Visited#{Neighbor => true},
              NewPoints = Points + 1,
              dfs(Neighbor, Graph, Capacity, NewVisited, NewPoints) > Acc;
            false ->
              Acc
          end
      end
    end,
    Points,
    Neighbors
  ),
  MaxPoints.