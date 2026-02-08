-module(solution).
-export([count_complete_components/2]).

count_complete_components(N, Edges) ->
  Graph = build_graph(N, Edges),
  Visited = sets:new(),
  count_components(Graph, N, Visited, 0).

count_components(_Graph, 0, _Visited, Count) ->
  Count;
count_components(Graph, N, Visited, Count) ->
  case find_unvisited(N, Visited) of
    none ->
      Count;
    Node ->
      {Nodes, EdgesInComponent} = explore_component(Graph, Node, sets:new()),
      Size = sets:size(Nodes),
      NumEdges = length(EdgesInComponent),
      if NumEdges == Size * (Size - 1) div 2 then
        NewCount = Count + 1
      else
        NewCount = Count
      end,
      NewVisited = sets:union(Visited, Nodes),
      count_components(Graph, N, NewVisited, NewCount)
  end.

build_graph(N, Edges) ->
  build_graph(N, Edges, []).

build_graph(0, _, Graph) ->
  Graph;
build_graph(N, Edges, Graph) ->
  NewGraph = lists:foldl(fun({U, V}, Acc) ->
                              Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                                  V => lists:append(maps:get(V, Acc, []), [U])}
                          end, Graph, Edges),
  build_graph(0, [], NewGraph).

find_unvisited(N, Visited) ->
  find_unvisited(1, N, Visited).

find_unvisited(Node, N, Visited) ->
  if Node > N then
    none
  else
    if sets:is_element(Node, Visited) then
      find_unvisited(Node + 1, N, Visited)
    else
      Node
    end
  end.

explore_component(Graph, StartNode, Visited) ->
  explore_component([StartNode], Graph, Visited, sets:new(), []).

explore_component([], _Graph, Visited, Nodes, Edges) ->
  {Nodes, Edges};
explore_component([Node | Rest], Graph, Visited, Nodes, Edges) ->
  if sets:is_element(Node, Nodes) then
    explore_component(Rest, Graph, Visited, Nodes, Edges)
  else
    NewNodes = sets:add_element(Node, Nodes),
    Neighbors = maps:get(Node, Graph, []),
    NewEdges = lists:foldl(fun(Neighbor, Acc) ->
                                 if Neighbor > Node then
                                   [{Node, Neighbor} | Acc]
                                 else
                                   Acc
                                 end
                             end, Edges, Neighbors),
    NewVisited = sets:add_element(Node, Visited),
    NewQueue = Rest ++ lists:filter(fun(Neighbor) -> not sets:is_element(Neighbor, NewNodes) end, Neighbors),
    explore_component(NewQueue, Graph, NewVisited, NewNodes, NewEdges)
  end.