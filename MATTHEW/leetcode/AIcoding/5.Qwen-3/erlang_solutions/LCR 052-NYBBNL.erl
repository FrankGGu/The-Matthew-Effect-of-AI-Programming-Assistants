-module(increasing_order_search_tree).
-export([increasingBST/1]).

increasingBST(Node) ->
    {NewRoot, _} = build_increasing_tree(Node, none),
    NewRoot.

build_increasing_tree(nil, _) ->
    {nil, nil};
build_increasing_tree(#bst{val=Val, left=Left, right=Right}, Parent) ->
    {LeftRoot, LeftTail} = build_increasing_tree(Left, nil),
    {RightRoot, RightTail} = build_increasing_tree(Right, nil),
    Node = #bst{val=Val, left=nil, right=RightRoot},
    if
        LeftTail == nil ->
            case Parent of
                nil -> {Node, Node};
                _ -> {Node, Node}
            end;
        true ->
            LeftTail#bst{right=Node},
            {LeftRoot, Node}
    end.