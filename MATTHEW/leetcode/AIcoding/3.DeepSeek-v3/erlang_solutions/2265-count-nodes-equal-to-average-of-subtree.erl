-spec average_of_subtree(Root :: #tree_node{} | null) -> integer().
average_of_subtree(Root) ->
    {Count, _Sum, _Size} = traverse(Root),
    Count.

traverse(null) ->
    {0, 0, 0};
traverse(#tree_node{val = Val, left = Left, right = Right}) ->
    {LeftCount, LeftSum, LeftSize} = traverse(Left),
    {RightCount, RightSum, RightSize} = traverse(Right),
    TotalSum = LeftSum + RightSum + Val,
    TotalSize = LeftSize + RightSize + 1,
    Average = TotalSum div TotalSize,
    NewCount = LeftCount + RightCount + (case Average == Val of true -> 1; false -> 0 end),
    {NewCount, TotalSum, TotalSize}.