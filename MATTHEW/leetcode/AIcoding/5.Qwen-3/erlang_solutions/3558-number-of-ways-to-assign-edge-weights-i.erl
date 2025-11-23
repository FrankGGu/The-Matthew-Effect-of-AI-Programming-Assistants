-module(number_of_ways_to_assign_edge_weights_i).
-export([numWays/1]).

numWays(Edges) ->
    Nodes = lists:usort(lists:flatten(Edges)),
    N = length(Nodes),
    Adj = maps:new(),
    lists:foreach(fun([U, V]) ->
        Adj1 = maps:update(U, [V | maps:get(U, Adj, [])], Adj),
        Adj2 = maps:update(V, [U | maps:get(V, Adj, [])], Adj1),
        Adj = Adj2
    end, Edges),
    Count = 0,
    dfs(1, -1, Adj, Count, N),
    Count.

dfs(Node, Parent, Adj, Count, N) ->
    Children = maps:get(Node, Adj, []),
    case Children of
        [] -> Count + 1;
        _ ->
            lists:foldl(fun(Child, Acc) ->
                if Child /= Parent ->
                    Acc + dfs(Child, Node, Adj, Count, N);
                true -> Acc
                end
            end, Count, Children)
    end.