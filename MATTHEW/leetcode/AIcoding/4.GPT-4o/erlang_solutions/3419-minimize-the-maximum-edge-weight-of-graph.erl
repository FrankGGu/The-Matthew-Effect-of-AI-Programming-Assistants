-module(solution).
-export([minimize_max_edge_weight/2]).

minimize_max_edge_weight(N, edges) ->
    Graph = build_graph(N, edges),
    case bin_search(1, 10^9, Graph) of
        {ok, Result} -> Result;
        _ -> -1
    end.

build_graph(N, Edges) ->
    Graph = lists:duplicate(N + 1, []),
    lists:foldl(fun({u, v, w}, Acc) ->
        Acc1 = lists:update_at(u, fun(L) -> [{v, w} | L] end, Acc),
        lists:update_at(v, fun(L) -> [{u, w} | L] end, Acc1)
    end, Graph, Edges).

bin_search(Low, High, Graph) ->
    if
        Low >= High -> {ok, Low};
        true ->
            Mid = (Low + High) div 2,
            if
                can_form_mst_with_max_weight(Graph, Mid) ->
                    bin_search(Low, Mid, Graph);
                true ->
                    bin_search(Mid + 1, High, Graph)
            end
    end.

can_form_mst_with_max_weight(Graph, MaxWeight) ->
    Visited = lists:duplicate(length(Graph), false),
    {Count, _} = dfs(1, MaxWeight, Visited, Graph),
    Count == length(Graph) - 1.

dfs(Node, MaxWeight, Visited, Graph) ->
    case lists:nth(Node, Visited) of
        true -> {0, Visited};
        false ->
            NewVisited = lists:update_at(Node, fun(_) -> true end, Visited),
            {Count, UpdatedVisited} = lists:foldl(fun({Next, Weight}, {C, V}) ->
                if
                    Weight =< MaxWeight -> dfs(Next, MaxWeight, V, Graph) + 1;
                    true -> {C, V}
                end
            end, {1, NewVisited}, lists:nth(Node, Graph)),
            {Count, UpdatedVisited}
    end.