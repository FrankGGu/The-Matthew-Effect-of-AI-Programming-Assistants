-record(tree_node, {val, left, right}).

-spec max_sum_bst(Root :: #tree_node{} | nil) -> integer().
max_sum_bst(Root) ->
    {_, _, _, _, MaxSum} = solve(Root),
    MaxSum.

solve(nil) ->
    {true, erlang:infinity(), erlang:neg_infinity(), 0, 0}.

solve(#tree_node{val = Val, left = Left, right = Right}) ->
    {IsLeftBST, LeftMin, LeftMax, LeftSum, LeftMaxBSTSumFound} = solve(Left),
    {IsRightBST, RightMin, RightMax, RightSum, RightMaxBSTSumFound} = solve(Right),

    IsCurrentBST = IsLeftBST andalso IsRightBST andalso (LeftMax < Val) andalso (Val < RightMin),

    if IsCurrentBST ->
        CurrentMin = min(LeftMin, Val),
        CurrentMax = max(RightMax, Val),
        CurrentSum = LeftSum + RightSum + Val,
        MaxBSTSum = lists:max([CurrentSum, LeftMaxBSTSumFound, RightMaxBSTSumFound]),
        {true, CurrentMin, CurrentMax, CurrentSum, MaxBSTSum};
    else ->
        MaxBSTSum = lists:max([LeftMaxBSTSumFound, RightMaxBSTSumFound]),
        {false, 0, 0, 0, MaxBSTSum}
    end.