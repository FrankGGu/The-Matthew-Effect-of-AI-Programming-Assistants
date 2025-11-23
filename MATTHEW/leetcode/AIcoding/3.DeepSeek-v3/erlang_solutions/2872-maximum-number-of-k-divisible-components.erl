-module(solution).
-export([max_k_divisible_components/3]).

max_k_divisible_components(N, Edges, Values, K) ->
    Tree = build_tree(Edges),
    {Count, _} = dfs(0, -1, Tree, Values, K),
    Count.

build_tree(Edges) ->
    Tree = maps:new(),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
                    maps:update_with(V, fun(L) -> [U | L] end, [U], Acc1)
                end, Tree, Edges).

dfs(Node, Parent, Tree, Values, K) ->
    Sum = lists:nth(Node + 1, Values),
    {Count, ChildSums} = lists:foldl(fun(Child, {C, Sums}) ->
                                        if
                                            Child =/= Parent ->
                                                {ChildCount, ChildSum} = dfs(Child, Node, Tree, Values, K),
                                                {C + ChildCount, [ChildSum | Sums]};
                                            true ->
                                                {C, Sums}
                                        end
                                    end, {0, []}, maps:get(Node, Tree, [])),
    TotalSum = Sum + lists:sum(ChildSums),
    if
        TotalSum rem K =:= 0 -> {Count + 1, 0};
        true -> {Count, TotalSum}
    end.