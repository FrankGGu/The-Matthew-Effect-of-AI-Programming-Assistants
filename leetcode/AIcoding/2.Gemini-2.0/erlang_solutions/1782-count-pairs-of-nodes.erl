-module(count_pairs).
-export([count_pairs/3]).

count_pairs(N, Edges, Queries) ->
  Adj = lists:foldl(fun([U, V], Acc) ->
                       Acc#{U => lists:sort(Acc[U] ++ [V]),
                             V => lists:sort(Acc[V] ++ [U])}
                     end,
                     lists:foldl(fun(I, Acc) -> Acc#{I => []} end, #{}, lists:seq(1, N)),
                     Edges),
  Degree = lists:foldl(fun(I, Acc) -> Acc ++ [length(Adj[I])] end, [], lists:seq(1, N)),
  lists:map(fun(Query) -> count_pairs_helper(N, Adj, Degree, Query) end, Queries).

count_pairs_helper(N, Adj, Degree, Query) ->
  count_pairs_helper(N, Adj, Degree, Query, 0, 1).

count_pairs_helper(N, Adj, Degree, Query, Count, I) when I > N ->
  Count;
count_pairs_helper(N, Adj, Degree, Query, Count, I) ->
  count_pairs_helper(N, Adj, Degree, Query, count_pairs_inner(N, Adj, Degree, Query, Count, I, I + 1), I + 1).

count_pairs_inner(N, Adj, Degree, Query, Count, I, J) when J > N ->
  Count;
count_pairs_inner(N, Adj, Degree, Query, Count, I, J) ->
  Sum = Degree[I - 1] + Degree[J - 1],
  Overlap = lists:foldl(fun(Neighbor, Acc) ->
                            if Neighbor == I ->
                              Acc + 1
                            else
                              Acc
                            end
                          end,
                          0,
                          lists:intersection(Adj[I], Adj[J])),
  if Sum - Overlap > Query ->
    count_pairs_inner(N, Adj, Degree, Query, Count + 1, I, J + 1)
  else
    count_pairs_inner(N, Adj, Degree, Query, Count, I, J + 1)
  end.