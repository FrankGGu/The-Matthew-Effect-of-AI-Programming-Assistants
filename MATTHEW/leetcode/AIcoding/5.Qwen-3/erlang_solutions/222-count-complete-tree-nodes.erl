-module(solution).
-export([count_nodes/1]).

-record(TreeNode, {val, left, right}).

count_nodes(undefined) -> 0;
count_nodes(Node) ->
    Left = Node#TreeNode.left,
    Right = Node#TreeNode.right,
    case count_depth(Left, 0) of
        D when D == count_depth(Right, 0) ->
            (1 bsl (D + 1)) - 1;
        _ ->
            1 + count_nodes(Left) + count_nodes(Right)
    end.

count_depth(undefined, D) -> D;
count_depth(Node, D) ->
    count_depth(Node#TreeNode.left, D + 1).