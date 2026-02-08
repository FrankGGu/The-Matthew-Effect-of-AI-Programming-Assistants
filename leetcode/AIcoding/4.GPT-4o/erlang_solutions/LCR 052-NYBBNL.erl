-module(solution).
-export([increasing_bst/1]).

-record(tree, {val, left = none, right = none}).

increasing_bst(Root) ->
    {NewRoot, _} = increasing_bst_helper(Root, none),
    NewRoot.

increasing_bst_helper(none, Acc) ->
    {Acc, Acc};
increasing_bst_helper(#tree{val=Val, left=Left, right=Right}, Acc) ->
    {NewRoot, NewAcc} = increasing_bst_helper(Left, Acc),
    NewNode = #tree{val=Val, left=none, right=none},
    case NewAcc of
        none -> {NewNode, NewNode};
        _ -> NewAcc#tree{right = NewNode}
    end,
    increasing_bst_helper(Right, NewNode).