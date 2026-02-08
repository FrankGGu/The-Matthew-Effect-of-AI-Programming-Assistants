-module(solution).
-export([maximize_target_nodes/2]).

maximize_target_nodes(Edges, Target) ->
    N = length(Edges) + 1,
    G = build_graph(Edges, N),
    TargetSet = sets:from_list(Target),
    {Max, _} = dfs(1, -1, G, TargetSet),
    Max.

build_graph(Edges, N) ->
    G = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
                    array:set(V, [U | array:get(V, Acc1)], Acc1)
                end, G, Edges).

dfs(Node, Parent, G, TargetSet) ->
    Children = [C || C <- array:get(Node, G), C =/= Parent],
    {Total, HasTarget} = lists:foldl(fun(Child, {Sum, Flag}) ->
                                         {SumC, FlagC} = dfs(Child, Node, G, TargetSet),
                                         {Sum + SumC, Flag or FlagC}
                                     end, {0, false}, Children),
    IsTarget = sets:is_element(Node, TargetSet),
    NewHasTarget = IsTarget or HasTarget,
    if
        IsTarget -> {Total + 1, true};
        NewHasTarget -> {Total + 1, true};
        true -> {Total, false}
    end.