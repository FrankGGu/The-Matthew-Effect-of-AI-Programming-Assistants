-module(minimum_edge_reversals).
-export([minimum_edge_reversals/2]).

minimum_edge_reversals(N, Edges) ->
  graph_to_adj_lists(N, Edges, Adj, RevAdj),
  [bfs(Node, Adj, RevAdj) || Node <- lists:seq(0, N - 1)].

graph_to_adj_lists(N, Edges, Adj, RevAdj) ->
  {Adj, RevAdj} = lists:foldl(
    fun([U, V], {AccAdj, AccRevAdj}) ->
      {lists:keyreplace(U, 1, AccAdj, {U, [V | proplists:get_value(U, AccAdj, [])]}),
       lists:keyreplace(V, 1, AccRevAdj, {V, [U | proplists:get_value(V, AccRevAdj, [])]})}
    end,
    {lists:zip(lists:seq(0, N - 1), lists:duplicate(N, [])), lists:zip(lists:seq(0, N - 1), lists:duplicate(N, []))},
    Edges
  ).

bfs(StartNode, Adj, RevAdj) ->
  bfs_helper([StartNode], sets:new(), 0, Adj, RevAdj).

bfs_helper([], _, Count, _, _) ->
  Count;
bfs_helper(Queue, Visited, Count, Adj, RevAdj) ->
  {CurrNode, Rest} = lists:split(1, Queue),
  Curr = lists:nth(1,CurrNode),
  if sets:is_element(Curr, Visited) ->
    bfs_helper(Rest, Visited, Count, Adj, RevAdj);
  true ->
    Neighbors = proplists:get_value(Curr, Adj, []) ++ proplists:get_value(Curr, RevAdj, []),
    NewQueue = Rest ++ lists:filter(fun(N) -> not sets:is_element(N, Visited) end, Neighbors),
    RevEdges = lists:filter(fun(N) -> lists:member(Curr, proplists:get_value(N, Adj, [])) end, proplists:get_keys(RevAdj)),
    NewCount = Count + length(RevEdges),
    bfs_helper(NewQueue, sets:add_element(Curr, Visited), NewCount - length(RevEdges), Adj, RevAdj)
  end.