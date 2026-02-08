-spec min_time(N :: integer(), Edges :: [[integer()]], HasApple :: [boolean()]) -> integer().
min_time(N, Edges, HasApple) ->
    Tree = build_tree(N, Edges),
    {Time, _} = dfs(0, -1, Tree, HasApple),
    Time.

build_tree(N, Edges) ->
    Tree = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = update_tree(Acc, U, V),
                    update_tree(Acc1, V, U)
                end, Tree, Edges).

update_tree(Tree, U, V) ->
    Children = lists:nth(U + 1, Tree),
    lists:sublist(Tree, U) ++ [[V | Children]] ++ lists:nthtail(U + 1, Tree).

dfs(Node, Parent, Tree, HasApple) ->
    Children = lists:nth(Node + 1, Tree),
    {TotalTime, TotalHasApple} = lists:foldl(fun(Child, {Time, Has}) ->
                                                if
                                                    Child =:= Parent -> {Time, Has};
                                                    true ->
                                                        {ChildTime, ChildHas} = dfs(Child, Node, Tree, HasApple),
                                                        {Time + ChildTime + 2, Has orelse ChildHas}
                                                end
                                            end, {0, false}, Children),
    Has = lists:nth(Node + 1, HasApple),
    if
        TotalHasApple orelse Has -> {TotalTime, true};
        true -> {0, false}
    end.