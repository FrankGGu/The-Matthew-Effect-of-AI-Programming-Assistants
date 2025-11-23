-module(maximum_weighted_k_edge_path).
-export([max_k_edges/2]).

max_k_edges(Graph, K) ->
    N = length(Graph),
    {MaxWeight, _} = lists:foldl(fun(I, Acc) -> find_path(I, 0, Graph, K, N, Acc) end, {0, []}, lists:seq(0, N-1)),

    MaxWeight.

find_path(Start, CurrentWeight, Graph, K, N, {MaxWeight, _}) ->
    case dfs(Start, -1, CurrentWeight, Graph, K, N, 0) of
        {Weight, _} when Weight > MaxWeight ->
            {Weight, []};
        _ ->
            {MaxWeight, []}
    end.

dfs(Node, Parent, CurrentWeight, Graph, K, N, Steps) ->
    if
        Steps == K ->
            {CurrentWeight, [Node]};
        true ->
            Children = lists:filter(fun(X) -> X /= Parent end, lists:nth(Node+1, Graph)),
            lists:foldl(fun(Child, {BestWeight, BestPath}) ->
                {ChildWeight, ChildPath} = dfs(Child, Node, CurrentWeight + lists:nth(Child+1, Graph), Graph, K, N, Steps + 1),
                if
                    ChildWeight > BestWeight ->
                        {ChildWeight, [Node | ChildPath]};
                    true ->
                        {BestWeight, BestPath}
                end
            end, {CurrentWeight, [Node]}, Children)
    end.