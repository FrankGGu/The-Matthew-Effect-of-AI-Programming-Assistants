-module(bst_inorder_successor).
-export([inorderSuccessor/2]).

-record(tree, {val, left, right}).

inorderSuccessor(_, null) ->
    null;
inorderSuccessor(Root, P) ->
    inorderSuccessorHelper(Root, P, null).

inorderSuccessorHelper(null, _, Successor) ->
    Successor;
inorderSuccessorHelper(Node, P, Successor) ->
    case Node#tree.val of
        Val when Val < P#tree.val ->
            inorderSuccessorHelper(Node#tree.right, P, Successor);
        Val when Val > P#tree.val ->
            inorderSuccessorHelper(Node#tree.left, P, Node);
        _ ->
            case Node#tree.right of
                null ->
                    Successor;
                _ ->
                    findMin(Node#tree.right)
            end
    end.

findMin(null) ->
    null;
findMin(Node) ->
    case Node#tree.left of
        null ->
            Node;
        _ ->
            findMin(Node#tree.left)
    end.