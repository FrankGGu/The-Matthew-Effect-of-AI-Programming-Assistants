-module(solution).
-export([add_one_row/2]).

-record(tree_node, {val, left, right}).

add_one_row(undefined, _v) -> undefined;
add_one_row(Node, V) -> add_one_row(Node, V, 1, 1).

add_one_row(Node, V, 1, 1) ->
    #tree_node{val=V, left=Node, right=undefined};
add_one_row(Node, V, Depth, 1) ->
    case Depth of
        1 -> Node;
        _ ->
            #tree_node{val=Node#tree_node.val,
                       left=add_one_row(Node#tree_node.left, V, Depth-1, 0),
                       right=add_one_row(Node#tree_node.right, V, Depth-1, 0)}
    end;
add_one_row(Node, V, Depth, 0) ->
    case Depth of
        1 ->
            #tree_node{val=V, left=Node, right=undefined};
        _ ->
            #tree_node{val=Node#tree_node.val,
                       left=add_one_row(Node#tree_node.left, V, Depth-1, 0),
                       right=add_one_row(Node#tree_node.right, V, Depth-1, 0)}
    end.