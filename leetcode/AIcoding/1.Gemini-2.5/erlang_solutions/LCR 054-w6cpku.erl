-module(solution).
-export([convert_bst/1]).

-record(treenode, {val, left = nil, right = nil}).

convert_bst(Root) ->
    {NewRoot, _} = convert_bst_helper(Root, 0),
    NewRoot.

convert_bst_helper(nil, CurrentSum) ->
    {nil, CurrentSum};
convert_bst_helper(Node, CurrentSum) ->
    {NewRight, SumAfterRight} = convert_bst_helper(Node#treenode.right, CurrentSum),
    NewVal = Node#treenode.val + SumAfterRight,
    {NewLeft, SumAfterLeft} = convert_bst_helper(Node#treenode.left, NewVal),
    {Node#treenode{val = NewVal, left = NewLeft, right = NewRight}, SumAfterLeft}.