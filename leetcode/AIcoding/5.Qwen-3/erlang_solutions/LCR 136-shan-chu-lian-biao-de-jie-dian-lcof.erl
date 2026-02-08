-module(delete_node).
-export([deleteNode/1]).

-record(list_node, {val, next}).

deleteNode(Node) ->
    case Node of
        #list_node{val = Val, next = Next} ->
            case Next of
                undefined ->
                    ok;
                _ ->
                    Node#list_node.val = Next#list_node.val,
                    Node#list_node.next = Next#list_node.next
            end
    end.