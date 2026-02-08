-module(solution).
-export([add_one_row/3]).

-record(node, {val, left = null, right = null}).

add_one_row(Root, Val, Depth) ->
    case Depth of
        1 -> #node{val = Val, left = Root};
        _ -> add_row(Root, Val, Depth, 1)
    end.

add_row(null, _, _, _) -> null;
add_row(Node, Val, Depth, CurrentDepth) ->
    if
        CurrentDepth =:= Depth - 1 ->
            #node{val = Val, left = Node#node.left, right = Node#node.right};
        true ->
            NewLeft = add_row(Node#node.left, Val, Depth, CurrentDepth + 1),
            NewRight = add_row(Node#node.right, Val, Depth, CurrentDepth + 1),
            #node{val = Node#node.val, left = NewLeft, right = NewRight}
    end.