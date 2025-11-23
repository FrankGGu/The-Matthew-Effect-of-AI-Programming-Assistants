-module(connectable_servers).
-export([count_pairs/2]).

count_pairs(N, Edges) ->
  count_pairs(N, Edges, 0).

count_pairs(N, Edges, SignalSpeed) ->
  Adj = build_adj(N, Edges),
  Result = lists:foldl(
    fun(Node, Acc) ->
      Acc + count_pairs_from_node(Node, N, Adj, SignalSpeed)
    end,
    0,
    lists:seq(1, N)
  ),
  Result div 2.

count_pairs_from_node(Node, N, Adj, SignalSpeed) ->
  Neighbors = maps:get(Node, Adj, []),
  counts_by_node(Node, Neighbors, N, Adj, SignalSpeed, []).

counts_by_node(_Node, [], _N, _Adj, _SignalSpeed, Acc) ->
  length(Acc) >= 2 andalso
    length(lists:usort(Acc)) == length(Acc)
  ? length(Acc) * (length(Acc) - 1) div 2
  ;
  length(Acc) < 2 ? 0 :
  length(lists:usort(Acc)) == length(Acc) ? length(Acc) * (length(Acc) - 1) div 2 : 0.

counts_by_node(Node, [ {Neighbor, Weight} | Rest], N, Adj, SignalSpeed, Acc) ->
  DistanceMap = bfs(Node, Neighbor, N, Adj),
  ReachableNodes = lists:filter(
    fun({Node2, Distance}) ->
       Node2 /= Node andalso Distance rem SignalSpeed == 0
    end,
    maps:to_list(DistanceMap)
  ),
  ReachableNodesList = [Node2 || {Node2, _} <- ReachableNodes],
  counts_by_node(Node, Rest, N, Adj, SignalSpeed, Acc ++ ReachableNodesList).

bfs(StartNode, ExcludeNode, N, Adj) ->
  Queue = [{StartNode, 0}],
  Visited = #{StartNode => 0},
  bfs_helper(Queue, ExcludeNode, N, Adj, Visited).

bfs_helper([], _ExcludeNode, _N, _Adj, Visited) ->
  Visited;
bfs_helper([{Node, Distance} | Rest], ExcludeNode, N, Adj, Visited) ->
  Neighbors = maps:get(Node, Adj, []),
  NewNeighbors = lists:filter(
    fun({Neighbor, _Weight}) ->
      not maps:is_key(Neighbor, Visited) andalso Neighbor /= ExcludeNode
    end,
    Neighbors
  ),
  NewQueue = Rest ++ [ {Neighbor, Distance + Weight} || {Neighbor, Weight} <- NewNeighbors],
  NewVisited = maps:merge(Visited, maps:from_list([ {Neighbor, Distance + Weight} || {Neighbor, Weight} <- NewNeighbors])),
  bfs_helper(NewQueue, ExcludeNode, N, Adj, NewVisited).

build_adj(N, Edges) ->
  lists:foldl(
    fun([U, V, Weight], Acc) ->
      Acc1 = maps:update_with(U, fun(List) -> [{V, Weight} | List] end, [{V, Weight}], Acc),
      maps:update_with(V, fun(List) -> [{U, Weight} | List] end, [{U, Weight}], Acc1)
    end,
    #{},
    Edges
  ).