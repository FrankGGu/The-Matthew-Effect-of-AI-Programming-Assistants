-module(solution).
-export([color_tree/1]).

color_tree(Root) ->
    color_tree_helper(Root, 0).

color_tree_helper(nil, _) -> 
    0;
color_tree_helper(Node, Color) ->
    NewColor = (Color + 1) rem 2,
    LeftCount = color_tree_helper(Node#node.left, NewColor),
    RightCount = color_tree_helper(Node#node.right, NewColor),
    if 
        Node#node.color == Color -> 
            1 + LeftCount + RightCount;
        true -> 
            LeftCount + RightCount
    end.