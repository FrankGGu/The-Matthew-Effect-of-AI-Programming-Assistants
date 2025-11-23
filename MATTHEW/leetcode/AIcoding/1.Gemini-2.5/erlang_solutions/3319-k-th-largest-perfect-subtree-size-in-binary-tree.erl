-record(tree_node, {val, left, right}).

kth_largest_perfect_subtree_size(Root, K) ->
    {_IsPerfect, _Height, ReversedAllSizes} = dfs_acc(Root, []),
    AllSizes = lists:reverse(ReversedAllSizes),
    SortedSizes = lists:sort(fun(A, B) -> A >= B end, AllSizes),
    lists:nth(K, SortedSizes).

dfs_acc(nil, Acc) ->
    {true, -1, Acc};

dfs_acc(#tree_node{val = _Val, left = Left, right = Right}, Acc) ->
    {LeftIsPerfect, LeftHeight, Acc1} = dfs_acc(Left, Acc),
    {RightIsPerfect, RightHeight, Acc2} = dfs_acc(Right, Acc1),

    if LeftIsPerfect and RightIsPerfect and (LeftHeight == RightHeight) ->
        CurrentHeight = LeftHeight + 1,
        CurrentSize = (1 bsl (CurrentHeight + 1)) - 1,
        {true, CurrentHeight, [CurrentSize | Acc2]};
    true ->
        {false, -1, Acc2}
    end.