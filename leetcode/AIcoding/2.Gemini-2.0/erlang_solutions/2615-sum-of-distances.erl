-module(sum_of_distances).
-export([sum_distances_in_tree/2]).

sum_distances_in_tree(N, Edges) ->
  graph_from_edges(Edges, N, Graph),
  distances(Graph, N).

graph_from_edges(Edges, N, Graph) ->
  lists:foldl(
    fun({U, V}, Acc) ->
      Acc1 = maps:update(U, [V | maps:get(U, Acc, [])], Acc),
      maps:update(V, [U | maps:get(V, Acc, [])], Acc1)
    end,
    maps:from_list([{I, []} || I <- lists:seq(1, N)]),
    Edges
  ).

distances(Graph, N) ->
  lists:map(fun(I) -> distance_sum(Graph, I, N) end, lists:seq(1, N)).

distance_sum(Graph, Start, N) ->
  distance_sum_helper(Graph, Start, N, maps:from_list([{Start, 0}]), [Start], 0).

distance_sum_helper(_Graph, _Start, _N, Visited, [], Acc) ->
  Acc;
distance_sum_helper(Graph, Start, N, Visited, [Current | Rest], Acc) ->
  Neighbors = maps:get(Current, Graph, []),
  NewNeighbors = lists:filter(
    fun(Neighbor) -> not maps:is_key(Neighbor, Visited) end,
    Neighbors
  ),
  NewVisited = lists:foldl(
    fun(Neighbor, AccVis) ->
      maps:put(Neighbor, maps:get(Current, Visited) + 1, AccVis)
    end,
    Visited,
    NewNeighbors
  ),
  NewAcc = Acc + maps:size(Visited) - 1,
  distance_sum_helper(Graph, Start, N, NewVisited, Rest ++ NewNeighbors, NewAcc).