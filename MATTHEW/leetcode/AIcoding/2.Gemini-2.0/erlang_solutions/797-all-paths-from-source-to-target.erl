-module(all_paths_source_target).
-export([all_paths_source_target/1]).

all_paths_source_target(Graph) ->
    Target = length(Graph) - 1,
    paths(0, Target, Graph, [0], []).

paths(Node, Target, Graph, CurrentPath, Acc) ->
    if Node == Target ->
        [lists:reverse(CurrentPath) | Acc];
    true ->
        NextNodes = lists:nth(Node + 1, Graph),
        lists:foldl(
            fun(NextNode, Acc1) ->
                paths(NextNode, Target, Graph, [NextNode | CurrentPath], Acc1)
            end,
            Acc,
            NextNodes
        )
    end.