-module(bst_to_greater_sum_tree).
-export([bstToGst/1]).

bstToGst(Root) ->
    {_, Root} = traverse(Root, 0),
    Root.

traverse(nil, Accum) ->
    {Accum, nil};
traverse(#{} = Node, Accum) ->
    {Accum, Right} = traverse(Node#node.right, Accum),
    NewVal = Node#node.val + Accum,
    {NewAccum, Left} = traverse(Node#node.left, NewVal),
    {NewAccum, #{}{val = NewVal, left = Left, right = Right}}.