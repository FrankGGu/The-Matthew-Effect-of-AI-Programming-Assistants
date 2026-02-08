-module(solution).
-export([maximum_score_after_operations/2]).

-spec maximum_score_after_operations(Edges :: [[integer()]], Values :: [integer()]) -> integer().
maximum_score_after_operations(Edges, Values) ->
    N = length(Values),
    Tree = build_tree(Edges, N),
    {Total, Min} = dfs(0, -1, Tree, Values),
    Total - Min.

build_tree(Edges, N) ->
    Tree = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    update_tree(Acc, U, V)
                end, Tree, Edges).

update_tree(Tree, U, V) ->
    Updated1 = update_tree_node(Tree, U, V),
    update_tree_node(Updated1, V, U).

update_tree_node(Tree, U, V) ->
    Children = lists:nth(U + 1, Tree),
    lists:sublist(Tree, U) ++ [[V | Children]] ++ lists:nthtail(U + 1, Tree).

dfs(Node, Parent, Tree, Values) ->
    Children = lists:filter(fun(C) -> C =/= Parent end, lists:nth(Node + 1, Tree)),
    case Children of
        [] ->
            {0, lists:nth(Node + 1, Values)};
        _ ->
            Sum = 0,
            MinSum = 0,
            {Total, Min} = lists:foldl(fun(Child, {AccTotal, AccMin}) ->
                {ChildTotal, ChildMin} = dfs(Child, Node, Tree, Values),
                {AccTotal + ChildTotal, AccMin + ChildMin}
            end, {Sum, MinSum}, Children),
            CurrentValue = lists:nth(Node + 1, Values),
            if
                Total + CurrentValue > Total + Min ->
                    {Total + CurrentValue, Min};
                true ->
                    {Total + Min, CurrentValue}
            end
    end.