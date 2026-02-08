-module(solution).
-export([all_paths_source_target/1]).

all_paths_source_target(Graph) ->
    Target = length(Graph) - 1,
    dfs(0, Graph, [0], Target).

dfs(Node, Graph, Path, Target) ->
    case Node of
        Target -> [lists:reverse(Path)];
        _ ->
            lists:flatmap(
                fun(NextNode) ->
                    dfs(NextNode, Graph, [NextNode | Path], Target)
                end,
                graphs:adjacent_nodes(Node, Graph)
            )
    end.

graphs:adjacent_nodes(Node, Graph) ->
    lists:nth(Node + 1, Graph).