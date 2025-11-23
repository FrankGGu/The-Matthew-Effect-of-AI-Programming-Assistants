-module(num_good_leaf_nodes_pairs).
-export([goodPairs/1]).

-type TreeNode() :: {TreeNode, integer(), TreeNode} | nil.

-spec goodPairs(TreeNode :: TreeNode()) -> integer().
goodPairs(nil) -> 0;
goodPairs({Left, Val, Right}) ->
    Count = goodPairs(Left) + goodPairs(Right),
    LeftCounts = countLeaves(Left),
    RightCounts = countLeaves(Right),
    Sum = lists:sum([Count * 1 || _ <- LeftCounts, _ <- RightCounts]),
    Count + Sum.

countLeaves(nil) -> [];
countLeaves({nil, Val, nil}) -> [Val];
countLeaves({Left, Val, Right}) ->
    LeftList = countLeaves(Left),
    RightList = countLeaves(Right),
    LeftList ++ RightList.