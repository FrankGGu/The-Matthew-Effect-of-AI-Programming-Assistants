-spec path_sum(Root :: #tree_node{} | null, TargetSum :: integer()) -> integer().
path_sum(Root, TargetSum) ->
    {Count, _} = helper(Root, TargetSum, []),
    Count.

helper(null, _TargetSum, _Path) ->
    {0, []};
helper(Node, TargetSum, Path) ->
    NewPath = [Node#tree_node.val | Path],
    {LeftCount, _} = helper(Node#tree_node.left, TargetSum, NewPath),
    {RightCount, _} = helper(Node#tree_node.right, TargetSum, NewPath),
    CurrentCount = count_sums(NewPath, TargetSum, 0, 0),
    {LeftCount + RightCount + CurrentCount, NewPath}.

count_sums([], _TargetSum, _CurrentSum, Count) ->
    Count;
count_sums([Val | Rest], TargetSum, CurrentSum, Count) ->
    NewSum = CurrentSum + Val,
    NewCount = if NewSum =:= TargetSum -> Count + 1; true -> Count end,
    count_sums(Rest, TargetSum, NewSum, NewCount).