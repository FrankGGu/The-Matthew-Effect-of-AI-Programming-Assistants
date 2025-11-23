-spec all_paths_source_target(Graph :: [[integer()]]) -> [[integer()]].
all_paths_source_target(Graph) ->
    N = length(Graph) - 1,
    dfs(0, N, Graph, [0], []).

dfs(Node, Target, Graph, Path, Acc) ->
    case Node =:= Target of
        true -> [lists:reverse(Path) | Acc];
        false ->
            lists:foldl(
                fun(Neighbor, A) ->
                    dfs(Neighbor, Target, Graph, [Neighbor | Path], A)
                end,
                Acc,
                lists:nth(Node + 1, Graph)
            )
    end.