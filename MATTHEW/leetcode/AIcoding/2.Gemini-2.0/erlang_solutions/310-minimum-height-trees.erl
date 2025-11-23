-module(minimum_height_trees).
-export([find_min_height_trees/1]).

find_min_height_trees(N) when N =< 0 ->
  [];
find_min_height_trees(1) ->
  [0];
find_min_height_trees(N) ->
  Edges = lists:seq(1, N - 1),
  Edges2 = lists:map(fun(I) -> {I - 1, I} end, Edges),
  find_min_height_trees_helper(N, Edges2).

find_min_height_trees_helper(N, Edges) ->
  Graph = create_graph(N, Edges),
  indegrees(Graph, N, []).

create_graph(N, Edges) ->
  lists:foldl(fun({U, V}, Acc) ->
                  Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                        V => lists:append(maps:get(V, Acc, []), [U])}
              end, #{}, Edges).

indegrees(Graph, N, Acc) ->
  Leaves = [V || V <- lists:seq(0, N - 1), length(maps:get(V, Graph)) =:= 1],
  if N =< 2 ->
    lists:sort(lists:flatten(lists:seq(0, N - 1)))
  else
    NewGraph = lists:foldl(fun(Leaf, G) ->
                                 Neighbors = maps:get(Leaf, G),
                                 lists:foldl(fun(Neighbor, G2) ->
                                                 G2#{Neighbor => lists:delete(Leaf, maps:get(Neighbor, G2))}
                                             end, G, Neighbors)
                             end, Graph, Leaves),
    NewN = N - length(Leaves),
    indegrees(NewGraph, NewN, Acc)
  end.