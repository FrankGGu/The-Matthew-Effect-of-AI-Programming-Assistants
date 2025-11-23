-module(bst_to_gst).
-export([bstToGst/1]).

-record(tree_node, {val, left, right}).

bstToGst(Root) ->
    {_, NewRoot} = bstToGstHelper(Root, 0),
    NewRoot.

bstToGstHelper(null, Sum) ->
    {Sum, null};
bstToGstHelper(Node, Sum) ->
    #tree_node{val = Val, left = Left, right = Right} = Node,
    {SumRight, NewRight} = bstToGstHelper(Right, Sum),
    NewVal = Val + SumRight,
    {SumLeft, NewLeft} = bstToGstHelper(Left, NewVal),
    {SumLeft, #tree_node{val = NewVal, left = NewLeft, right = NewRight}}.