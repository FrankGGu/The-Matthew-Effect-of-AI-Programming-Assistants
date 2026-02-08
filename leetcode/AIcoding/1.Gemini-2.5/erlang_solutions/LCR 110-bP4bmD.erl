-module(solution).
-export([all_paths_source_target/1]).

all_paths_source_target(Graph) ->
    N = length(Graph),
    Target = N - 1,
    dfs(0, [0], Graph, Target, []).

dfs(Node, Path, Graph, Target, Acc) when Node == Target ->
    [lists:reverse(Path) | Acc];
dfs(Node, Path, Graph, Target, Acc) ->
    Neighbors = lists:nth(Node + 1, Graph),
    lists:foldl(fun(Neighbor, CurrentAcc) ->
                        dfs(Neighbor, [Neighbor | Path], Graph, Target, CurrentAcc)
                end, Acc, Neighbors).