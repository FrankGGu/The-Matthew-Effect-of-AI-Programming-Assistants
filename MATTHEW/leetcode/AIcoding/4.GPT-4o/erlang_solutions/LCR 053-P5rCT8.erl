-module(solution).
-export([inorder_successor/2]).

-record(node, {val, left = null, right = null}).

inorder_successor(Node, P) ->
    case find(Node, P) of
        null -> null;
        Successor -> Successor
    end.

find(null, _) -> null;
find(Node, P) ->
    if
        Node#node.val > P#node.val ->
            case find(Node#node.left, P) of
                null -> Node;
                LeftSuccessor -> LeftSuccessor
            end;
        Node#node.val =< P#node.val ->
            find(Node#node.right, P)
    end.