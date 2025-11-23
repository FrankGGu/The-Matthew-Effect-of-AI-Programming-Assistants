-module(solution).
-export([reachable_nodes/3]).

reachable_nodes(N, Edges, Restricted) ->
    RestrictedSet = sets:from_list(Restricted),
    Adj = build_adjacency(N, Edges),
    Visited = sets:new(),
    dfs(0, Adj, RestrictedSet, Visited).

build_adjacency(N, Edges) ->
    Adj = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = setelement(U + 1, Acc, [V | element(U + 1, Acc)]),
                    setelement(V + 1, Acc1, [U | element(V + 1, Acc1)])
                end, list_to_tuple(Adj), Edges).

dfs(Node, Adj, Restricted, Visited) ->
    case sets:is_element(Node, Restricted) orelse sets:is_element(Node, Visited) of
        true -> 0;
        false ->
            Visited1 = sets:add_element(Node, Visited),
            Neighbors = element(Node + 1, Adj),
            lists:foldl(fun(Neighbor, Acc) ->
                            Acc + dfs(Neighbor, Adj, Restricted, Visited1)
                        end, 1, Neighbors)
    end.