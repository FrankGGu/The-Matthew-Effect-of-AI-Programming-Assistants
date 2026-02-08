-module(solution).
-export([bst_to_gst/1]).

-record(tree_node, {val, left, right}).

bst_to_gst(Root) ->
    {ModifiedRoot, _} = bst_to_gst_helper(Root, 0),
    ModifiedRoot.

bst_to_gst_helper(nil, CurrentSum) ->
    {nil, CurrentSum};
bst_to_gst_helper(Node, CurrentSum) ->
    {RightModified, SumAfterRight} = bst_to_gst_helper(Node#tree_node.right, CurrentSum),

    NewNodeVal = Node#tree_node.val + SumAfterRight,

    {LeftModified, SumAfterLeft} = bst_to_gst_helper(Node#tree_node.left, NewNodeVal),

    {Node#tree_node{val = NewNodeVal, left = LeftModified, right = RightModified}, SumAfterLeft}.