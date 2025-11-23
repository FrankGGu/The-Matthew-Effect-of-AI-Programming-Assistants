-module(critical_connections).
-export([critical_connections/1]).

critical_connections(N, Connections) ->
    graph_adj(Connections, Adj),
    dfs(0, -1, 0, [], Adj, [], []).

graph_adj(Connections, Adj) ->
    lists:foldl(fun({U, V}, Acc) ->
                        Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                              V => lists:append(maps:get(V, Acc, []), [U])}
                end, #{}, Connections).

dfs(Node, Parent, Rank, Adj, GraphAdj, Visited, Critical) ->
    case lists:member(Node, Visited) of
        true ->
            {Rank, Critical};
        false ->
            {NewRank, NewCritical} =
                lists:foldl(fun(Neighbor, {CurrRank, CurrCritical}) ->
                                    if Neighbor == Parent then
                                        {CurrRank, CurrCritical}
                                    else
                                        case lists:member(Neighbor, Visited) of
                                            true ->
                                                {min(CurrRank, maps:get(Neighbor, Rank, CurrRank)), CurrCritical};
                                            false ->
                                                {NextRank, NextCritical} = dfs(Neighbor, Node, Rank + 1, Adj, GraphAdj, lists:append([Node], Visited), CurrCritical);
                                                if NextRank > Rank then
                                                    {CurrRank, lists:append([lists:sort([Node, Neighbor])], NextCritical)}
                                                else
                                                    {min(CurrRank, NextRank), NextCritical}
                                        end
                                    end
                            end, {Rank, Critical}, maps:get(Node, GraphAdj, [])),
            {NewRank, NewCritical}
    end.

critical_connections(N, Connections) ->
    graph_adj(Connections, Adj),
    {_, Critical} = dfs(0, -1, 0, Adj, Adj, [], []),
    Critical.