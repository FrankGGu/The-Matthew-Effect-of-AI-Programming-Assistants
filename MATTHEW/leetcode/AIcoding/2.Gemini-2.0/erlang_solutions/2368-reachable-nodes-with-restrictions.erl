-module(reachable_nodes).
-export([reachable_nodes/2]).

reachable_nodes(N, Restricted) ->
  graph_nodes_reachable(N, Restricted).

graph_nodes_reachable(N, Restricted) ->
  Graph = create_graph(N, Restricted),
  restricted_set(Restricted, RestrictedSet),
  dfs(0, Graph, RestrictedSet, [0]).

create_graph(N, Restricted) ->
  Edges = [ [U,V] || U <- lists:seq(0, N-1), V <- lists:seq(U+1, N-1) ],
  create_adjacency_list(N, Edges, Restricted).

create_adjacency_list(N, Edges, Restricted) ->
  create_adjacency_list_helper(N, Edges, Restricted, []).

create_adjacency_list_helper(N, [], Restricted, Acc) ->
  lists:sort(Acc);
create_adjacency_list_helper(N, [[U,V]|Rest], Restricted, Acc) ->
  case lists:member(U, Restricted) orelse lists:member(V, Restricted) of
    true ->
      create_adjacency_list_helper(N, Rest, Restricted, Acc);
    false ->
      create_adjacency_list_helper(N, Rest, Restricted, [ {U, V}, {V, U} | Acc])
  end.

restricted_set([], []) ->
  [].
restricted_set(Restricted, RestrictedSet) ->
  lists:usort(Restricted).

dfs(Node, Graph, RestrictedSet, Visited) ->
  Neighbors = get_neighbors(Node, Graph, RestrictedSet),
  dfs_helper(Neighbors, Graph, RestrictedSet, Visited).

dfs_helper([], Graph, RestrictedSet, Visited) ->
  length(Visited);
dfs_helper([Neighbor|Rest], Graph, RestrictedSet, Visited) ->
  case lists:member(Neighbor, Visited) of
    true ->
      dfs_helper(Rest, Graph, RestrictedSet, Visited);
    false ->
      dfs_helper(Rest ++ get_neighbors(Neighbor, Graph, RestrictedSet), Graph, RestrictedSet, [Neighbor|Visited])
  end.

get_neighbors(Node, Graph, RestrictedSet) ->
  Neighbors = [ V || {U,V} <- Graph, U == Node, not lists:member(V, RestrictedSet)],
  lists:usort(Neighbors).