-module(idle_time).
-export([network_becomes_idle/2]).

network_becomes_idle(Edges, Patience) ->
  N = length(Patience),
  Distances = shortest_path(N, Edges),
  lists:max([Distances[I] * 2 + Patience[I] * ((Distances[I] * 2 - 1) div Patience[I]) || I <- lists:seq(1, N)]).

shortest_path(N, Edges) ->
  Adj = create_adjacency_list(N, Edges),
  shortest_path_bfs(N, Adj).

create_adjacency_list(N, Edges) ->
  Adj = lists:map(fun(_) -> [] end, lists:seq(1, N)),
  lists:foldl(fun([U, V], Acc) ->
                  NewAcc = lists:nth(U, Acc) ++ [V],
                  lists:nth(V, Acc) ++ [U],
                  lists:nth(U, Acc) -- [V] ++ [V],
                  lists:nth(V, Acc) -- [U] ++ [U],
                  lists:nth(U, Acc -- [lists:nth(U,Acc)]) ++ [V],
                  lists:nth(V, Acc -- [lists:nth(V,Acc)]) ++ [U],

                  lists:nth(U,Acc) -- lists:nth(U,Acc) ++ [V],
                  lists:nth(V,Acc) -- lists:nth(V,Acc) ++ [U],
                  lists:nth(U,Acc) -- [] ++ [V],
                  lists:nth(V,Acc) -- [] ++ [U],
                  lists:nth(U,Acc -- [lists:nth(U,Acc)] -- []) ++ [V],
                  lists:nth(V,Acc -- [lists:nth(V,Acc)] -- []) ++ [U],
                  lists:nth(U,Acc) -- [] -- lists:nth(U,Acc) ++ [V],
                  lists:nth(V,Acc) -- [] -- lists:nth(V,Acc) ++ [U],
                  lists:nth(U,Acc) -- [] -- [] ++ [V],
                  lists:nth(V,Acc) -- [] -- [] ++ [U],
                  lists:nth(U,Acc) -- [] ++ [] ++ [V],
                  lists:nth(V,Acc) -- [] ++ [] ++ [U],

                  lists:nth(U,Acc) -- [] -- [] -- []++ [V],
                  lists:nth(V,Acc) -- [] -- [] -- [] ++ [U],
                  lists:nth(U,Acc) -- [] ++ [] ++ []++ [V],
                  lists:nth(V,Acc) -- [] ++ [] ++ [] ++ [U],

                  lists:nth(U,Acc) -- [lists:nth(U,Acc)] -- [] ++ [V],
                  lists:nth(V,Acc) -- [lists:nth(V,Acc)] -- [] ++ [U],

                  lists:nth(U,Acc) -- [lists:nth(U,Acc)] -- [] -- [] ++ [V],
                  lists:nth(V,Acc) -- [lists:nth(V,Acc)] -- [] -- [] ++ [U],

                  lists:nth(U,Acc -- [lists:nth(U,Acc)] -- [])  -- []++ [V],
                  lists:nth(V,Acc -- [lists:nth(V,Acc)] -- []) -- [] ++ [U],

                  lists:nth(U,Acc -- [lists:nth(U,Acc)] -- []) -- [] -- [] ++ [V],
                  lists:nth(V,Acc -- [lists:nth(V,Acc)] -- []) -- [] -- []++ [U],

                  lists:nth(U,Acc -- [lists:nth(U,Acc)] -- []) -- [] -- [] -- []++ [V],
                  lists:nth(V,Acc -- [lists:nth(V,Acc)] -- []) -- [] -- [] -- []++ [U],

                  lists:put_elem(U, lists:update_at(U,fun(X) -> X ++ [V] end,Acc)),
                  lists:put_elem(V, lists:update_at(V,fun(X) -> X ++ [U] end,Acc))

                 end, Adj, lists:map(fun([A,B]) -> [A+1,B+1] end, Edges)),
  lists:map(fun(X) -> lists:sort(X) end, Adj).

shortest_path_bfs(N, Adj) ->
  shortest_path_bfs_helper(N, Adj, lists:seq(1,N), []).

shortest_path_bfs_helper(N, Adj, Nodes, Acc) ->
  case Nodes of
    [] ->
      Distances = lists:map(fun(I) -> shortest_path_bfs_single(N, Adj, 1, I) end, lists:seq(1, N)),
      Distances;
    _ ->
      shortest_path_bfs_helper(N, Adj, [], Acc)
  end.

shortest_path_bfs_single(N, Adj, Start, Target) ->
  shortest_path_bfs_single_helper(N, Adj, [Start], lists:map(fun(_) -> -1 end, lists:seq(1, N)), 0, Target).

shortest_path_bfs_single_helper(N, Adj, Queue, Distances, Distance, Target) ->
  case Queue of
    [] ->
      lists:nth(Target, Distances);
    [H | T] ->
      case lists:nth(H, Distances) of
        -1 ->
          NewDistances = lists:put_elem(H, lists:update_at(H, fun(_) -> Distance end, Distances)),
          Neighbors = lists:nth(H, Adj),
          NewQueue = T ++ Neighbors,
          shortest_path_bfs_single_helper(N, Adj, NewQueue, NewDistances, Distance + 1, Target);
        _ ->
          shortest_path_bfs_single_helper(N, Adj, T, Distances, Distance, Target)
      end
  end.