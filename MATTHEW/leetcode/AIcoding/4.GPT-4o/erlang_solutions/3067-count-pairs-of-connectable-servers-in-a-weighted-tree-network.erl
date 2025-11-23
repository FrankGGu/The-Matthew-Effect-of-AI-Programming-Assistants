-module(solution).
-export([count_pairs/2]).

count_pairs(N, Edges) ->
    Tree = build_tree(N, Edges),
    {Count, _} = dfs(Tree, 1, 0, []),
    Count.

build_tree(N, Edges) ->
    Lists = lists:foldl(fun({A, B}, Acc) ->
        maps:update_with(A, fun(X) -> [B | X] end, fun() -> [B] end, Acc)
    end, maps:from_list([{X, []} || X <- lists:seq(1, N)]), Edges),
    Lists.

dfs(Tree, Node, Parent, Visited) ->
    {Count, SubtreeSize} = lists:foldl(fun(Child, {C, S}) ->
        if
            Child =:= Parent -> {C, S};
            true -> 
                {C1, S1} = dfs(Tree, Child, Node, Visited),
                {C + S1 * (1 + (length(Visited) - S1)), S + S1}
        end
    end, {0, 1}, maps:get(Node, Tree)),
    {Count, SubtreeSize}.