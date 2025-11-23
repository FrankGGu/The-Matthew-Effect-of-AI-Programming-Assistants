-module(solution).
-export([bst_to_gst/1]).

bst_to_gst(Root) ->
    {_FinalSum, NewRoot} = bst_to_gst_helper(Root, 0),
    NewRoot.

bst_to_gst_helper(nil, CurrentSum) ->
    {CurrentSum, nil};
bst_to_gst_helper({Value, Left, Right}, CurrentSum) ->
    {SumFromRight, NewRight} = bst_to_gst_helper(Right, CurrentSum),
    NewValue = Value + SumFromRight,
    {FinalSum, NewLeft} = bst_to_gst_helper(Left, NewValue),
    {FinalSum, {NewValue, NewLeft, NewRight}}.