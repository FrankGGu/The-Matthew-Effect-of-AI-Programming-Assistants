-module(max_diff_price_sum).
-export([max_diff_price_sum/2]).

max_diff_price_sum(N, Edges) ->
  graph(N, Edges, Prices) ->
    Prices = lists:seq(1, N),
    Graph = create_graph(N, Edges),
    max_diff_price_sum_helper(Graph, Prices).

max_diff_price_sum_helper(Graph, Prices) ->
  N = length(Prices),
  {_, MaxPathSum} = dfs(1, 0, Graph, Prices, lists:seq(1, N), []),
  MaxPathSum.

create_graph(N, Edges) ->
  Graph = lists:foldl(
            fun([U, V], Acc) ->
              Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                    V => lists:append(maps:get(V, Acc, []), [U])}
            end,
            #{},
            Edges
          ),
  Graph.

dfs(Node, Parent, Graph, Prices, Visited, Path) ->
  NewPath = lists:append(Path, [Node]),
  Visited1 = lists:delete(Node, Visited),
  Neighbors = maps:get(Node, Graph, []),
  FilteredNeighbors = lists:filter(
                        fun(Neighbor) ->
                          Neighbor /= Parent
                        end,
                        Neighbors
                      ),
  case Visited1 of
    [] ->
      PathSum = lists:sum([Prices !! (Index - 1) || Index <- NewPath]),
      {Node, PathSum};
    _ ->
      Result = lists:map(
                 fun(Neighbor) ->
                   dfs(Neighbor, Node, Graph, Prices, Visited1, NewPath)
                 end,
                 FilteredNeighbors
               ),
      PathSum = lists:sum([Prices !! (Index - 1) || Index <- NewPath]),
      MaxSubPathSum = case Result of
                        [] -> 0;
                        _ -> lists:max([Sum || {_, Sum} <- Result])
                      end,
      {Node, PathSum + MaxSubPathSum}
  end.