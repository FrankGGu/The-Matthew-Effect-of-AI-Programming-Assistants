-module(ice_breaking).
-export([solve/1]).

solve(A) ->
  N = length(A),
  {_, Count} = lists:foldl(
    fun(I, {Visited, Acc}) ->
      if lists:member(I, Visited) then
        {Visited, Acc}
      else
        {DFSVisited, NewAcc} = dfs(I, A, [I], []),
        {Visited ++ DFSVisited, Acc + 1}
      end
    end,
    {[], 0},
    lists:seq(1, N)
  ),
  Count.

dfs(Node, A, Visited, Acc) ->
  Neighbors = lists:nth(Node, A),
  lists:foldl(
    fun(Neighbor, {V, A1}) ->
      if lists:member(Neighbor, V) then
        {V, A1}
      else
        {V1, A2} = dfs(Neighbor, A, [Neighbor | V], A1),
        {V1, A2}
      end
    end,
    {Visited, Acc},
    Neighbors
  ).