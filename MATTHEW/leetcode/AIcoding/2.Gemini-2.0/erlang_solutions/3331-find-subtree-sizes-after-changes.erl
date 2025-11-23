-module(find_subtree_sizes).
-export([find_subtree_sizes/2]).

find_subtree_sizes(N, Edges) ->
  Graph = create_graph(N, Edges),
  Results = lists:seq(1, N),
  lists:map(fun(QueryNode) -> subtree_size_after_change(N, Graph, QueryNode) end, Results).

create_graph(N, Edges) ->
  create_graph(N, Edges, array:new({fixed, N}, [])).

create_graph(0, _, Graph) ->
  Graph;
create_graph(N, [], Graph) ->
  create_graph(N - 1, [], array:set(N, [], Graph));
create_graph(N, [[U, V] | Rest], Graph) ->
  Graph1 = add_edge(U, V, Graph),
  Graph2 = add_edge(V, U, Graph1),
  create_graph(N, Rest, Graph2).

add_edge(U, V, Graph) ->
  Neighbors = case array:is_defined(U, Graph) of
    true -> array:get(U, Graph);
    false -> []
  end,
  array:set(U, [V | Neighbors], Graph).

subtree_size_after_change(N, Graph, QueryNode) ->
  {RemovedEdge, NewGraph} = remove_edge_to_parent(QueryNode, Graph),
  {AddedEdge, FinalGraph} = add_edge_to_parent(QueryNode, NewGraph),
  Size = subtree_size(QueryNode, FinalGraph, []),
  restore_graph(FinalGraph, RemovedEdge, AddedEdge).

remove_edge_to_parent(QueryNode, Graph) ->
  {Parent, NewGraph} = find_parent_and_remove_edge(QueryNode, Graph, 0, []);
  case Parent of
    0 -> {{0, 0}, Graph};
    _ -> {{Parent, QueryNode}, NewGraph}
  end.

find_parent_and_remove_edge(QueryNode, Graph, Parent, Visited) ->
  Neighbors = array:get(QueryNode, Graph),
  FilteredNeighbors = lists:filter(fun(Neighbor) -> not lists:member(Neighbor, Visited) end, Neighbors),
  case FilteredNeighbors of
    [] -> {Parent, Graph};
    [Neighbor | _] ->
      NewGraph = remove_edge(QueryNode, Neighbor, Graph),
      {Neighbor, NewGraph}
  end.

remove_edge(U, V, Graph) ->
  NeighborsU = array:get(U, Graph),
  NewNeighborsU = lists:filter(fun(Neighbor) -> Neighbor /= V end, NeighborsU),
  array:set(U, NewNeighborsU, Graph).

add_edge_to_parent(QueryNode, Graph) ->
  {Parent, NewGraph} = find_new_parent_and_add_edge(QueryNode, Graph, 0, []);
  case Parent of
    0 -> {{0, 0}, Graph};
    _ -> {{Parent, QueryNode}, NewGraph}
  end.

find_new_parent_and_add_edge(QueryNode, Graph, Parent, Visited) ->
  Neighbors = array:get(QueryNode, Graph),
  FilteredNeighbors = lists:filter(fun(Neighbor) -> not lists:member(Neighbor, Visited) end, Neighbors),
  case FilteredNeighbors of
    [] -> {Parent, Graph};
    [Neighbor | _] ->
      NewGraph = add_edge(QueryNode, Neighbor, Graph),
      {Neighbor, NewGraph}
  end.

subtree_size(Node, Graph, Visited) ->
  subtree_size(Node, Graph, Visited, 1).

subtree_size(Node, Graph, Visited, Acc) ->
  Neighbors = array:get(Node, Graph),
  NewVisited = [Node | Visited],
  NewNeighbors = lists:filter(fun(Neighbor) -> not lists:member(Neighbor, NewVisited) end, Neighbors),
  lists:foldl(fun(Neighbor, Acc1) -> subtree_size(Neighbor, Graph, NewVisited, Acc1) end, Acc, NewNeighbors).

restore_graph(Graph, {Parent1, Child1}, {Parent2, Child2}) ->
  case Parent1 of
    0 -> ok;
    _ ->
      Graph1 = add_edge(Parent1, Child1, Graph),
      Graph2 = remove_edge(Parent2, Child2, Graph1)
  end.