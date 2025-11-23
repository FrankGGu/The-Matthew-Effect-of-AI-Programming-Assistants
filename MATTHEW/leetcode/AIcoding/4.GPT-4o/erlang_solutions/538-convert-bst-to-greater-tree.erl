-module(solution).
-export([convert_bst/1]).

%% Definition for a binary tree node.
-record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

%% Convert BST to Greater Tree.
-spec convert_bst(Root :: #tree_node{} | null) -> #tree_node{} | null.
convert_bst(Root) ->
    convert_bst(Root, 0).

%% Helper function to convert the tree with accumulator for the sum.
-spec convert_bst(#tree_node{} | null, integer()) -> #tree_node{} | null.
convert_bst(null, Acc) -> 
    null;
convert_bst(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    %% First, traverse the right subtree, then process the current node, then the left.
    NewAcc = convert_bst(Right, Acc),
    NewVal = Val + NewAcc,
    NewRight = convert_bst(Right, NewVal),
    NewLeft = convert_bst(Left, NewVal),
    #tree_node{val = NewVal, left = NewLeft, right = NewRight}.

%% Initial call to start the transformation from the root.
convert_bst(Root) ->
    convert_bst(Root, 0).
