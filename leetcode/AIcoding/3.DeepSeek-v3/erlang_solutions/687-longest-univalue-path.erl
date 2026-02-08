-spec longest_univalue_path(Root :: #tree_node{} | null) -> integer().
longest_univalue_path(Root) ->
    {Max, _} = helper(Root),
    Max.

helper(null) ->
    {0, 0};
helper(#tree_node{val = Val, left = Left, right = Right}) ->
    {LeftMax, LeftLen} = helper(Left),
    {RightMax, RightLen} = helper(Right),
    LeftPath = case Left of
        #tree_node{val = Val} -> LeftLen + 1;
        _ -> 0
    end,
    RightPath = case Right of
        #tree_node{val = Val} -> RightLen + 1;
        _ -> 0
    end,
    CurrentMax = max(max(LeftMax, RightMax), LeftPath + RightPath),
    CurrentLen = max(LeftPath, RightPath),
    {CurrentMax, CurrentLen}.