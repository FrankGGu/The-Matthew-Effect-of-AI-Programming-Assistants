-spec max_path_sum(Root :: #TreeNode{} | null) -> integer().
max_path_sum(null) -> 0;
max_path_sum(Root) ->
    {MaxPath, _} = traverse(Root),
    MaxPath.

traverse(null) -> {-2147483648, -2147483648};
traverse(#TreeNode{val = Val, left = Left, right = Right}) ->
    {LeftMax, LeftGain} = traverse(Left),
    {RightMax, RightGain} = traverse(Right),
    MaxGain = lists:max([Val, Val + LeftGain, Val + RightGain]),
    MaxPath = lists:max([LeftMax, RightMax, Val + LeftGain + RightGain, MaxGain]),
    {MaxPath, MaxGain}.