-spec max_sum_bst(Root :: #tree_node{} | null) -> integer().
max_sum_bst(Root) ->
    {_, _, _, MaxSum} = traverse(Root),
    max(0, MaxSum).

traverse(null) ->
    {true, 0, infinity, -infinity};
traverse(#tree_node{val = Val, left = Left, right = Right}) ->
    {IsLeftBST, LeftSum, LeftMin, LeftMax} = traverse(Left),
    {IsRightBST, RightSum, RightMin, RightMax} = traverse(Right),
    CurrentIsBST = IsLeftBST andalso IsRightBST andalso (LeftMax < Val) andalso (Val < RightMin),
    CurrentSum = if
        CurrentIsBST -> LeftSum + RightSum + Val;
        true -> -1
    end,
    CurrentMin = min(Val, min(LeftMin, RightMin)),
    CurrentMax = max(Val, max(LeftMax, RightMax)),
    MaxSum = max(CurrentSum, max(LeftSum, RightSum)),
    {CurrentIsBST, CurrentSum, CurrentMin, CurrentMax}.