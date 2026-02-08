-module(solution).
-export([allPathsSourceTarget/1]).

allPathsSourceTarget(Graph) ->
    N = length(Graph),
    Target = N - 1,
    dfs(0, [0], Graph, Target).

dfs(CurrentNode, CurrentPath, _Graph, Target) when CurrentNode == Target ->
    [lists:reverse(CurrentPath)];
dfs(CurrentNode, CurrentPath, Graph, Target) ->
    Neighbors = lists:nth(CurrentNode + 1, Graph),
    lists:flatmap(
        fun(Neighbor) ->
            dfs(Neighbor, [Neighbor | CurrentPath], Graph, Target)
        end,
        Neighbors
    ).