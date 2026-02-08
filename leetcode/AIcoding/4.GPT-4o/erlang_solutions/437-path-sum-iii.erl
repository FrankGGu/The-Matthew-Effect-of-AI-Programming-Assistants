%% Definition for a binary tree node.
-record(tree_node, {val = 0 :: integer(),
                    left = null :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec path_sum(#tree_node{} | null, integer()) -> integer().
path_sum(Root, TargetSum) ->
    path_sum_helper(Root, TargetSum, []).

-spec path_sum_helper(#tree_node{} | null, integer(), [integer()]) -> integer().
path_sum_helper(null, _TargetSum, _CurrSums) -> 0;
path_sum_helper(#tree_node{val = Val, left = Left, right = Right}, TargetSum, CurrSums) ->
    NewSums = [Val + S || S <- CurrSums] ++ [Val],
    Count = length([_ || S <- NewSums, S =:= TargetSum]),
    Count + path_sum_helper(Left, TargetSum, NewSums) + path_sum_helper(Right, TargetSum, NewSums).
