-module(solution).
-export([bst_to_gst/1]).

-record(node, {val, left = null, right = null}).

bst_to_gst(Root) ->
    Total = sum_tree(Root),
    bst_to_gst_helper(Root, Total).

bst_to_gst_helper(null, _) -> null;
bst_to_gst_helper(#node{val = Val, left = Left, right = Right} = Node, Total) ->
    NewVal = Total - Val,
    NewNode = Node#node{val = NewVal},
    NewNode#node{right = bst_to_gst_helper(Right, NewVal + Val),
                  left = bst_to_gst_helper(Left, Total)}.

sum_tree(null) -> 0;
sum_tree(#node{val = Val, left = Left, right = Right}) ->
    Val + sum_tree(Left) + sum_tree(Right).