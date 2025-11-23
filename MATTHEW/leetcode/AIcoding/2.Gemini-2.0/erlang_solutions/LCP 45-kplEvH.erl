-module(bike_tricks).
-export([longest_path/1]).

longest_path(edges) ->
  graph_max_path(build_graph(edges)).

build_graph(Edges) ->
  lists:foldl(fun({U, V}, Graph) ->
                  add_edge(U, V, Graph)
              end, #{}, Edges).

add_edge(U, V, Graph) ->
  Graph1 = maps:update_with(U, fun(Neighbors) -> [V | Neighbors] end, [V], Graph),
  maps:update_with(V, fun(Neighbors) -> [U | Neighbors] end, [U], Graph1).

graph_max_path(Graph) ->
  nodes_list(Graph, []).

nodes_list(Graph, Acc) ->
  case maps:is_empty(Graph) of
    true ->
      max_path_length(Acc, 0);
    false ->
      {Node, Neighbors} = maps:to_list(Graph) ++ [{none, []}],
       case Node == none of
         true ->
           max_path_length(Acc, 0);
         false ->
           NewGraph = maps:remove(Node, Graph),
           paths_from_node(Node, NewGraph, Acc)
       end
  end.

paths_from_node(Node, Graph, Acc) ->
  paths_from_node_helper(Node, Graph, [Node], Acc).

paths_from_node_helper(Node, Graph, Path, Acc) ->
  Neighbors = maps:get(Node, Graph, []),
  case Neighbors of
    [] ->
      [Path | Acc];
    _ ->
      paths_from_neighbors(Node, Graph, Path, Neighbors, Acc)
  end.

paths_from_neighbors(_Node, Graph, Path, [], Acc) ->
  [Path | Acc];

paths_from_neighbors(Node, Graph, Path, [Neighbor | Rest], Acc) ->
  case lists:member(Neighbor, Path) of
    true ->
      paths_from_neighbors(Node, Graph, Path, Rest, Acc);
    false ->
      NewGraph = maps:update_with(Node, fun(Neighbors) -> lists:delete(Neighbor, Neighbors) end, [], Graph),
      UpdatedGraph = maps:update_with(Neighbor, fun(Neighbors) -> lists:delete(Node, Neighbors) end, [], NewGraph),
      NewPath = [Neighbor | Path],
      NewAcc = paths_from_node_helper(Neighbor, UpdatedGraph, NewPath, Acc),
      paths_from_neighbors(Node, Graph, Path, Rest, NewAcc)
  end.

max_path_length([], Max) ->
  Max;
max_path_length([Path | Rest], Max) ->
  Length = length(Path),
  NewMax = max(Max, Length),
  max_path_length(Rest, NewMax).