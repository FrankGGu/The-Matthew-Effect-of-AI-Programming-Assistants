-module(flatten_binary_tree_to_linked_list).
-export([flatten/1]).

-record(tree_node, {val, left, right}).

flatten(undefined) ->
    ok;
flatten(Node) ->
    flatten(Node, undefined).

flatten(#tree_node{left=Left, right=Right}=Node, Prev) ->
    case Left of
        undefined ->
            case Right of
                undefined ->
                    Node#tree_node{left=Prev, right=undefined};
                _ ->
                    NewNode = Node#tree_node{left=Prev, right=undefined},
                    flatten(Right, NewNode)
            end;
        _ ->
            case Right of
                undefined ->
                    NewNode = Node#tree_node{left=Prev, right=undefined},
                    flatten(Left, NewNode);
                _ ->
                    NewNode = Node#tree_node{left=Prev, right=undefined},
                    flatten(Left, NewNode),
                    flatten(Right, NewNode)
            end
    end.