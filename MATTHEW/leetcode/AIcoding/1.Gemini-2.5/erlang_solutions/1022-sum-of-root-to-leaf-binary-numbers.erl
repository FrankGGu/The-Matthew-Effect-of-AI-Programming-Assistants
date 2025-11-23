-record('TreeNode', {val = 0, left = null, right = null}).

-spec sumRootToLeaf(Root :: #'TreeNode'{} | null) -> integer().
sumRootToLeaf(Root) ->
    sum_helper(Root, 0).

sum_helper(null, _CurrentVal) ->
    0;
sum_helper(Node, CurrentVal) ->
    NewVal = CurrentVal * 2 + Node#'TreeNode'.val,
    case {Node#'TreeNode'.left, Node#'TreeNode'.right} of
        {null, null} -> % Leaf node
            NewVal;
        {Left, Right} -> % Not a leaf node
            LeftSum = sum_helper(Left, NewVal),
            RightSum = sum_helper(Right, NewVal),
            LeftSum + RightSum
    end.