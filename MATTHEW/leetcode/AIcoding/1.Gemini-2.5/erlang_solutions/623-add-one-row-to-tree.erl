-record('TreeNode', {val, left, right}).

add_one_row(Root, Val, 1) ->
    #'TreeNode'{val=Val, left=Root, right=nil};
add_one_row(Root, Val, Depth) ->
    add_one_row_at_depth(Root, 1, Depth, Val).

add_one_row_at_depth(nil, _CurrentDepth, _TargetDepth, _Val) ->
    nil;
add_one_row_at_depth(Node, CurrentDepth, TargetDepth, Val) when CurrentDepth == TargetDepth - 1 ->
    NewLeftNode = #'TreeNode'{val=Val, left=Node#TreeNode.left, right=nil},
    NewRightNode = #'TreeNode'{val=Val, left=nil, right=Node#TreeNode.right},
    Node#TreeNode{left=NewLeftNode, right=NewRightNode};
add_one_row_at_depth(Node, CurrentDepth, TargetDepth, Val) ->
    NewLeft = add_one_row_at_depth(Node#TreeNode.left, CurrentDepth + 1, TargetDepth, Val),
    NewRight = add_one_row_at_depth(Node#TreeNode.right, CurrentDepth + 1, TargetDepth, Val),
    Node#TreeNode{left=NewLeft, right=NewRight}.