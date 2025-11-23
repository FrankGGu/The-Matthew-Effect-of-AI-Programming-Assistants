-module(increasing_order_search_tree).
-export([increasingBST/1]).

-record(TreeNode, {val, left, right}).

increasingBST(Node) ->
    {NewRoot, _} = build_increasing_tree(Node, none),
    NewRoot.

build_increasing_tree(nil, _) ->
    {nil, nil};
build_increasing_tree(#TreeNode{val=Val, left=Left, right=Right}, Parent) ->
    {LeftRoot, LeftTail} = build_increasing_tree(Left, #TreeNode{val=Val, left=nil, right=nil}),
    {RightRoot, RightTail} = build_increasing_tree(Right, RightTail),
    case LeftTail of
        nil ->
            NewNode = #TreeNode{val=Val, left=nil, right=RightRoot},
            {NewNode, RightTail};
        _ ->
            LeftTail#TreeNode{right= #TreeNode{val=Val, left=nil, right=RightRoot}},
            {LeftRoot, RightTail}
    end.