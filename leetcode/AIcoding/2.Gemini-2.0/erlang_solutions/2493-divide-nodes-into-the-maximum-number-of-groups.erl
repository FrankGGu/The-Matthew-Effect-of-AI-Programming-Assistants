-module(max_groups).
-export([maximum_groups/1]).

maximum_groups(Edges) ->
  N = lists:max([max_node(E) || E <- Edges]),
  Graph = lists:foldl(fun({U, V}, G) -> add_edge(U, V, G) end, init_graph(N), Edges),

  Distances = bfs(Graph, N),

  MaxDistance = lists:max(Distances),

  if is_bipartite(Graph, N, Distances) then
    (N * (N + 1)) div 2
  else
    -1
  end.

init_graph(N) ->
  lists:foldl(fun(I, G) -> maps:put(I, [], G) end, #{}, lists:seq(1, N)).

add_edge(U, V, Graph) ->
  Graph1 = maps:update_with(U, fun(Neighbors) -> [V | Neighbors] end, [V], Graph),
  maps:update_with(V, fun(Neighbors) -> [U | Neighbors] end, [U], Graph1).

bfs(Graph, N) ->
  bfs_helper([1], maps:from_list([{I, -1} || I <- lists:seq(1, N)]), [1], Graph, N).

bfs_helper([], Distances, _, _, _) ->
  [maps:get(I, Distances) || I <- maps:keys(Distances)];
bfs_helper([Node | Rest], Distances, Visited, Graph, N) ->
  Neighbors = maps:get(Node, Graph),
  NewNodes = [Neighbor || Neighbor <- Neighbors, not lists:member(Neighbor, Visited)],
  UpdatedDistances = lists:foldl(fun(Neighbor, Acc) -> 
                                    if maps:get(Neighbor, Acc) == -1 then
                                      maps:put(Neighbor, maps:get(Node, Acc) + 1, Acc)
                                    else
                                      Acc
                                    end
                                  end, Distances, NewNodes),
  bfs_helper(Rest ++ NewNodes, UpdatedDistances, Visited ++ NewNodes, Graph, N).

is_bipartite(Graph, N, Distances) ->
  lists:all(fun(Node) ->
                Neighbors = maps:get(Node, Graph),
                lists:all(fun(Neighbor) ->
                              maps:get(Node, Distances) =/= -1 andalso maps:get(Neighbor, Distances) =/= -1 andalso abs(maps:get(Node, Distances) - maps:get(Neighbor, Distances)) =< 1
                          end, Neighbors)
            end, lists:seq(1, N)).

max_node({U, V}) ->
  max(U, V).