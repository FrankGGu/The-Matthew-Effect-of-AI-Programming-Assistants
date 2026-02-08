-module(solution).
-export([max_path_sum/1]).

-record(tree_node, {val, left, right}).

max_path_sum(Root) ->
    % Initialize global maximum with a value smaller than any possible path sum.
    % Node values are between -1000 and 1000. Max nodes 3*10^4.
    % Smallest possible sum is -1000 * 3*10^4 = -3*10^7.
    % -10^9 is a safe lower bound.
    {_MaxPathFromRoot, GlobalMaxSum} = max_path_sum_helper(Root, -1000000001),
    GlobalMaxSum.

max_path_sum_helper(nil, CurrentMaxSum) ->
    % If the node is nil, it contributes 0 to any path extending from its parent,
    % and does not change the global maximum.
    {0, CurrentMaxSum};

max_path_sum_helper(#tree_node{val = Val, left = Left, right = Right}, CurrentMaxSum) ->
    % Recursively calculate max path sums for left and right children
    {LeftMaxPath, MaxSum1} = max_path_sum_helper(Left, CurrentMaxSum),
    {RightMaxPath, MaxSum2} = max_path_sum_helper(Right, MaxSum1),

    % Calculate the maximum contribution from a child branch.
    % If a child branch's max path sum is negative, we choose to not extend the path to it (contribute 0).
    LeftContribution = max(0, LeftMaxPath),
    RightContribution = max(0, RightMaxPath),

    % Calculate the maximum path sum that can extend upwards from this node to its parent.
    % This path must go through 'Val' and can only choose one child branch (or none if both are negative).
    MaxPathFromNodeToParent = Val + max(LeftContribution, RightContribution),

    % Calculate the maximum path sum that passes THROUGH this node.
    % This path can use 'Val' and extend to both left and right children (if their contributions are positive).
    % This is a candidate for the global maximum path sum.
    PathThroughNode = Val + LeftContribution + RightContribution,

    % Update the global maximum sum with the current node's 'PathThroughNode' candidate.
    UpdatedGlobalMaxSum = max(MaxSum2, PathThroughNode),

    % Return the path sum that can be extended upwards to the parent, and the updated global max sum.
    {MaxPathFromNodeToParent, UpdatedGlobalMaxSum}.