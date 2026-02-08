-module(delete_node_in_bst).
-export([deleteNode/2]).

-record(bst, {val, left, right}).

deleteNode(nil, _) -> nil;
deleteNode(Node, Key) ->
    #bst{val = Val, left = Left, right = Right} = Node,
    if
        Val == Key ->
            case Left of
                nil -> Right;
                _ ->
                    MinNode = findMin(Right),
                    Node#bst{val = MinNode#bst.val, right = deleteNode(Right, MinNode#bst.val)}
            end;
        Val < Key ->
            Node#bst{right = deleteNode(Right, Key)};
        true ->
            Node#bst{left = deleteNode(Left, Key)}
    end.

findMin(nil) -> nil;
findMin(Node) ->
    case Node#bst:left of
        nil -> Node;
        _ -> findMin(Node#bst:left)
    end.