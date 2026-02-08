-module(solution).
-export([postorder_traversal/1]).

-record(tree_node, {val, left = null, right = null}).

-spec postorder_traversal(TreeNode :: 'null' | #tree_node{}) -> [integer()].
postorder_traversal('null') -> [];
postorder_traversal(#tree_node{val = Val, left = Left, right = Right}) ->
    postorder_traversal(Left) ++ postorder_traversal(Right) ++ [Val].