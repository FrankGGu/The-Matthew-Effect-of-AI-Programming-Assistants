-module(solution).
-export([maximum_score_after_operations_on_tree/3]).

maximum_score_after_operations_on_tree(_N, Edges, Values) ->
    Adj = build_adj(Edges),
    {Dp0, Dp1} = dfs(0, -1, Adj, Values),
    max(Dp0, Dp1).

build_adj(Edges) ->
    lists:foldl(fun([U, V], Acc) ->
        maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
        maps:update_with(V, fun(List) -> [U | List] end, [U], Acc)
    end, maps:new(), Edges).

dfs(U, Parent, Adj, Values) ->
    Children = maps:get(U, Adj, []),
    FilteredChildren = lists:filter(fun(V) -> V /= Parent end, Children),

    if
        FilteredChildren == [] ->
            {0, lists:nth(U + 1, Values)};
        true ->
            Dp0_sum = 0,
            Dp1_sum = lists:nth(U + 1, Values),

            {FinalDp0_sum, FinalDp1_sum} = lists:foldl(
                fun(V, {CurrentDp0_sum, CurrentDp1_sum}) ->
                    {ChildDp0, ChildDp1} = dfs(V, U, Adj, Values),
                    {CurrentDp0_sum + max(ChildDp0, ChildDp1),
                     CurrentDp1_sum + ChildDp0}
                end,
                {Dp0_sum, Dp1_sum},
                FilteredChildren
            ),
            {FinalDp0_sum, FinalDp1_sum}
    end.

max(A, B) when A >= B -> A;
max(A, B) -> B.