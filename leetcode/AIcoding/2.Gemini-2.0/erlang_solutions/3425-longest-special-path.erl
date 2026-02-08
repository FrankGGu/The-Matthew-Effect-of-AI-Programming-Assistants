-module(longest_special_path).
-export([longest_path/2]).

longest_path(N, Edges) ->
  Graph = create_graph(N, Edges),
  longest_path_helper(Graph, 1, N, []).

create_graph(N, Edges) ->
  create_graph_helper(N, Edges, lists:seq(1, N), []).

create_graph_helper(_, [], [], Acc) ->
  Acc;
create_graph_helper(N, Edges, [Node | RestNodes], Acc) ->
  Neighbors = [V || {U, V} <- Edges, U == Node] ++ [U || {U, V} <- Edges, V == Node],
  create_graph_helper(N, Edges, RestNodes, [{Node, Neighbors} | Acc]).

longest_path_helper(Graph, Start, N, Visited) ->
  Neighbors = get_neighbors(Graph, Start),
  ValidNeighbors = [Neighbor || Neighbor <- Neighbors, not lists:member(Neighbor, Visited)],
  case ValidNeighbors of
    [] ->
      length(Visited) + 1;
    _ ->
      lists:max([longest_path_helper(Graph, Neighbor, N, [Start | Visited]) || Neighbor <- ValidNeighbors])
  end.

get_neighbors(Graph, Node) ->
  case lists:keyfind(Node, 1, Graph) of
    {_, Neighbors} ->
      Neighbors;
    false ->
      []
  end.