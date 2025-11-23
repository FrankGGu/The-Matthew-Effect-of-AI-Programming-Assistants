-spec all_paths_source_target(Graph :: [[integer()]]) -> [[integer()]].
all_paths_source_target(Graph) ->
    N = length(Graph),
    dfs(0, N - 1, Graph, [0], []).

dfs(Current, Target, Graph, Path, Acc) ->
    case Current =:= Target of
        true -> [lists:reverse(Path) | Acc];
        false ->
            lists:foldl(
                fun(Next, Acc1) ->
                    dfs(Next, Target, Graph, [Next | Path], Acc1)
                end,
                Acc,
                lists:nth(Current + 1, Graph)
            )
    end.