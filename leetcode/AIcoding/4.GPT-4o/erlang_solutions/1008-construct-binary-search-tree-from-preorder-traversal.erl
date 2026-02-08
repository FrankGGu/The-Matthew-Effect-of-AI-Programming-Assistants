-module(solution).
-export([bst_from_preorder/1]).

-record(node, {val, left = null, right = null}).

bst_from_preorder(Preorder) ->
    bst_from_preorder(Preorder, self()).

bst_from_preorder([], _Parent) -> 
    null;
bst_from_preorder([H | T], Parent) ->
    Node = #node{val = H},
    add_node(Node, T, Parent),
    Node.

add_node(Node, [], _Parent) -> 
    Node;
add_node(Node, [H | T], Parent) ->
    if 
        H < Node#node.val ->
            Node#node.left = add_node(#node{val = H}, T, Node),
            Node;
        H >= Node#node.val ->
            Node#node.right = add_node(#node{val = H}, T, Node),
            Node
    end.