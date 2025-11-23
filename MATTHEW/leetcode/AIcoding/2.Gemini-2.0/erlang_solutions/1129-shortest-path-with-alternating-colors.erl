-module(shortest_path_alternating_colors).
-export([shortest_path/2]).

shortest_path(N, EdgesRed, EdgesBlue) ->
  graph_red(EdgesRed, N, GraphRed),
  graph_blue(EdgesBlue, N, GraphBlue),
  bfs(N, GraphRed, GraphBlue).

graph_red(Edges, N, Graph) ->
  lists:foldl(fun({U, V}, Acc) ->
                  case maps:is_key(U, Acc) of
                    true ->
                      maps:update(U, lists:union(maps:get(U, Acc), [V]), Acc);
                    false ->
                      maps:put(U, [V], Acc)
                  end
              end,
              maps:new(),
              Edges).

graph_blue(Edges, N, Graph) ->
  lists:foldl(fun({U, V}, Acc) ->
                  case maps:is_key(U, Acc) of
                    true ->
                      maps:update(U, lists:union(maps:get(U, Acc), [V]), Acc);
                    false ->
                      maps:put(U, [V], Acc)
                  end
              end,
              maps:new(),
              Edges).

bfs(N, GraphRed, GraphBlue) ->
  bfs_helper(N, GraphRed, GraphBlue, [{0, red, 0}, {0, blue, 0}], lists:duplicate(N, undefined), [[0, red], [0, blue]]).

bfs_helper(N, GraphRed, GraphBlue, [], Dist, _) ->
  lists:map(fun(undefined) -> -1; (Num) -> Num end, Dist);
bfs_helper(N, GraphRed, GraphBlue, [{Node, Color, Distance} | Queue], Dist, Visited) ->
  NewDist = case lists:nth(Node + 1, Dist) of
              undefined ->
                lists:nthreplace(Node + 1, Dist, Distance);
              Num when Num > Distance ->
                lists:nthreplace(Node + 1, Dist, Distance);
              _ ->
                Dist
            end,
  Neighbors = case Color of
                red ->
                  case maps:is_key(Node, GraphBlue) of
                    true ->
                      lists:map(fun(Neighbor) -> {Neighbor, blue, Distance + 1} end, maps:get(Node, GraphBlue));
                    false ->
                      []
                  end;
                blue ->
                  case maps:is_key(Node, GraphRed) of
                    true ->
                      lists:map(fun(Neighbor) -> {Neighbor, red, Distance + 1} end, maps:get(Node, GraphRed));
                    false ->
                      []
                  end
              end,
  NewQueue = Queue ++ lists:filter(fun({Neighbor, NextColor, _}) ->
                                       not lists:member([Neighbor, NextColor], Visited)
                                   end, Neighbors),
  NewVisited = Visited ++ lists:map(fun({NodeV, ColorV, _}) -> [NodeV, ColorV] end, lists:filter(fun({Neighbor, NextColor, _}) ->
                                       not lists:member([Neighbor, NextColor], Visited)
                                   end, Neighbors)),
  bfs_helper(N, GraphRed, GraphBlue, NewQueue, NewDist, NewVisited).