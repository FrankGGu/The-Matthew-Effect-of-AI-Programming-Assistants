-module(solution).
-export([convert_bst/1]).

-record(node, {val, left = nil, right = nil}).

convert_bst(Root) ->
    {Sum, _} = convert_bst_helper(Root, 0),
    Sum.

convert_bst_helper(nil, Acc) ->
    {Acc, nil};
convert_bst_helper(#node{val=Val, left=Left, right=Right}, Acc) ->
    {NewAcc, RightNode} = convert_bst_helper(Right, Acc),
    NewVal = Val + NewAcc,
    {NewAcc + Val, #node{val=NewVal, left=Left, right=RightNode}}.