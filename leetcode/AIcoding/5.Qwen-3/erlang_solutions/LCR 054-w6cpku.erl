-module(convert_bst_to_greater_tree).
-export([convert_bst/1]).

-record(TreeNode, {val, left, right}).

convert_bst(nil) ->
    nil;
convert_bst(Node) ->
    convert_bst(Node, 0).

convert_bst(#TreeNode{val=Val, left=Left, right=Right}, Accum) ->
    NewRight = convert_bst(Right, Accum),
    NewAccum = Val + Accum,
    NewLeft = convert_bst(Left, NewAccum),
    #TreeNode{val=NewAccum, left=NewLeft, right=NewRight}.