-module(all_paths).
-export([all_paths_source_target/2]).

all_paths_source_target(Graph, Source, Target) ->
    dfs(Graph, Source, Target, [], []).

dfs(_Graph, Target, Target, Path, Acc) ->
    [lists:reverse([Target | Path]) | Acc];
dfs(Graph, Curr, Target, Path, Acc) ->
    case maps:get(Curr, Graph, []) of
        [] ->
            Acc;
        Neighbors ->
            lists:foldl(
                fun(Neighbor, Acc1) ->
                    dfs(Graph, Neighbor, Target, [Curr | Path], Acc1)
                end,
                Acc,
                Neighbors
            )
    end.