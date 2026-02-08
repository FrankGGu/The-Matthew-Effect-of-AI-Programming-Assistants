-spec find_mode(Root :: #tree_node{} | null) -> [integer()].
find_mode(null) -> [];
find_mode(Root) ->
    {Counts, Max} = traverse(Root, #{}, 0),
    [Val || {Val, Cnt} <- maps:to_list(Counts), Cnt =:= Max].

traverse(null, Counts, Max) -> {Counts, Max};
traverse(#tree_node{val = Val, left = Left, right = Right}, Counts, Max) ->
    {Counts1, Max1} = traverse(Left, Counts, Max),
    NewCount = maps:get(Val, Counts1, 0) + 1,
    Counts2 = Counts1#{Val => NewCount},
    Max2 = max(Max1, NewCount),
    traverse(Right, Counts2, Max2).