-module(collect_coins).
-export([collect_coins/1]).

collect_coins(Edges) ->
  N = lists:foldl(fun({U, V}, Acc) -> max(max(U, V), Acc) end, 0, Edges) + 1,
  Adj = lists:foldl(fun({U, V}, Acc) ->
                       Acc#{U => lists:sort(Acc:get(U, []) ++ [V]),
                             V => lists:sort(Acc:get(V, []) ++ [U])}
                    end, #{}, Edges),
  collect_coins_helper(N, Adj).

collect_coins_helper(N, Adj) ->
  TrimmedAdj = trim_leaves(N, Adj),
  TrimmedAdj2 = trim_leaves(N, TrimmedAdj),
  EdgesLeft = count_edges(TrimmedAdj2),
  max(0, EdgesLeft - 1).

trim_leaves(N, Adj) ->
  Leaves = [V || V <- lists:seq(1, N), map_size(Adj:get(V, #{}) )== 1 ],
  lists:foldl(fun(Leaf, AccAdj) ->
                Neighbors = AccAdj:get(Leaf, []),
                if
                  Neighbors == [] ->
                    AccAdj,
                  true ->
                    Neighbor = lists:nth(1, Neighbors),
                    AccAdj#{Leaf => [],
                           Neighbor => lists:delete(Leaf, AccAdj:get(Neighbor, []))}
                end
              end, Adj, Leaves).

count_edges(Adj) ->
  lists:foldl(fun(K, Acc) ->
                Acc + length(Adj:get(K, []))
              end, 0, maps:keys(Adj)) div 2.