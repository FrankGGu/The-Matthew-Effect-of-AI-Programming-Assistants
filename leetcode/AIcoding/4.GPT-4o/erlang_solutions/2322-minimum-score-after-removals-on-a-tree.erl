module solution.

-export([min_score_after_removals/2]).

min_score_after_removals(N, Edges) ->
    Graph = create_graph(N, Edges),
    {Min, _} = dfs(Graph, 1, [], lists:duplicate(N, false)),
    Min.

create_graph(N, Edges) ->
    Graph = lists:duplicate(N + 1, []),
    lists:foldl(fun({U, V}, Acc) ->
        lists:update_element(U, lists:append(lists:element(U, Acc), [V]), Acc),
        lists:update_element(V, lists:append(lists:element(V, Acc), [U]), Acc)
    end, Graph, Edges).

dfs(Graph, Node, Visited, Path) ->
    case lists:nth(Node, Visited) of
        true -> {infinity, Path};
        false ->
            NewVisited = lists:update_element(Node, true, Visited),
            {Min, NewPath} = lists:foldl(fun(Neighbor, {CurMin, CurPath}) ->
                {NeighborMin, _} = dfs(Graph, Neighbor, NewVisited, [Node | CurPath]),
                {min(CurMin, NeighborMin), CurPath}
            end, {lists:nth(Node, Path), Path}, lists:nth(Node, Graph)),
            {min(Node, Min), NewPath}
    end.