-record('TreeNode', {val, left, right}).

kth_smallest(Root, K) ->
    {found, Value} = kth_smallest_inorder(Root, K, 0),
    Value.

kth_smallest_inorder(nil, _K, Count) ->
    {not_found, Count}.
kth_smallest_inorder(#'TreeNode'{val = Val, left = Left, right = Right}, K, Count) ->
    case kth_smallest_inorder(Left, K, Count) of
        {found, FoundVal} ->
            {found, FoundVal};
        {not_found, LeftCount} ->
            CurrentTotalCount = LeftCount + 1,
            if CurrentTotalCount == K ->
                {found, Val};
            true ->
                kth_smallest_inorder(Right, K, CurrentTotalCount)
            end
    end.