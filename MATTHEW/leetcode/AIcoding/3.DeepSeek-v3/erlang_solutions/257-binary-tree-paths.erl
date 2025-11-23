-spec binary_tree_paths(Root :: #tree_node{} | null) -> [unicode:unicode_binary()].
binary_tree_paths(null) -> [];
binary_tree_paths(Root) -> 
    Paths = dfs(Root, [], []),
    lists:map(fun(Path) -> unicode:characters_to_binary(Path) end, Paths).

dfs(#tree_node{val = Val, left = null, right = null}, Path, Acc) ->
    NewPath = Path ++ integer_to_list(Val),
    [NewPath | Acc];
dfs(#tree_node{val = Val, left = Left, right = Right}, Path, Acc) ->
    NewPath = Path ++ integer_to_list(Val) ++ "->",
    NewAcc = case Left of
        null -> Acc;
        _ -> dfs(Left, NewPath, Acc)
    end,
    case Right of
        null -> NewAcc;
        _ -> dfs(Right, NewPath, NewAcc)
    end.