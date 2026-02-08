-module(maximum_sum_bst).
-export([max_sum_bst/1]).

-record(result, {is_bst, min, max, sum, max_sum}).

max_sum_bst(Root) ->
    {_, MaxSum} = max_sum_bst_helper(Root),
    MaxSum.

max_sum_bst_helper(null) ->
    {#result{is_bst = true, min = infinity, max = -infinity, sum = 0, max_sum = 0}, 0};
max_sum_bst_helper(TreeNode) ->
    Val = maps:get(val, TreeNode),
    Left = maps:get(left, TreeNode, null),
    Right = maps:get(right, TreeNode, null),
    {LeftResult, LeftMaxSum} = max_sum_bst_helper(Left),
    {RightResult, RightMaxSum} = max_sum_bst_helper(Right),

    if LeftResult#result.is_bst and RightResult#result.is_bst and Val > LeftResult#result.max and Val < RightResult#result.min ->
        Sum = LeftResult#result.sum + RightResult#result.sum + Val,
        MaxSum = max([LeftMaxSum, RightMaxSum, Sum]),
        NewMin = min([Val, LeftResult#result.min]),
        NewMax = max([Val, RightResult#result.max]),
        {#result{is_bst = true, min = NewMin, max = NewMax, sum = Sum, max_sum = MaxSum}, MaxSum}