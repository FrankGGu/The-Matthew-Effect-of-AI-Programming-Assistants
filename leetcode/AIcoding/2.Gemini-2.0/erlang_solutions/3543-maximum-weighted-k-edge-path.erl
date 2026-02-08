-module(solution).
-export([solve/2]).

solve(N, Edges, K) ->
  graph_to_adj_list(Edges, N, AdjList),
  max_weighted_k_edge_path(N, AdjList, K).

graph_to_adj_list(Edges, N, AdjList) ->
  lists:foldl(
    fun({U, V, W}, Acc) ->
      AdjList1 = lists:keyreplace(U, 1, Acc, {U, []}),
      AdjList2 = lists:keyreplace(V, 1, AdjList1, {V, []}),
      {_, NeighborsU} = lists:keyfind(U, 1, AdjList2),
      {_, NeighborsV} = lists:keyfind(V, 1, AdjList2),
      lists:keyreplace(U, 1, AdjList2, {U, [{V, W} | NeighborsU]}),
      lists:keyreplace(V, 1, AdjList2, {V, [{U, W} | NeighborsV]})
    end,
    lists:map(fun(I) -> {I, []} end, lists:seq(1, N)),
    Edges
  ).

max_weighted_k_edge_path(N, AdjList, K) ->
  max_weighted_k_edge_path_helper(N, AdjList, K, 1, [], 0).

max_weighted_k_edge_path_helper(_N, _AdjList, 0, _CurrNode, _Visited, AccWeight) ->
  AccWeight;
max_weighted_k_edge_path_helper(N, AdjList, K, CurrNode, Visited, AccWeight) ->
  {_, Neighbors} = lists:keyfind(CurrNode, 1, AdjList),
  PossiblePaths = [
    max_weighted_k_edge_path_helper(N, AdjList, K - 1, NextNode, [CurrNode | Visited], AccWeight + Weight)
    || {NextNode, Weight} <- Neighbors,
       not lists:member(NextNode, Visited)
  ],
  case PossiblePaths of
    [] -> AccWeight;
    _ -> lists:max([AccWeight | PossiblePaths])
  end.