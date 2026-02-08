%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec delete_node(Node :: #list_node{}) -> void.
delete_node(Node) ->
    case Node#list_node.next of
        null -> Node;  % In this case, do nothing as this should not happen based on problem constraints.
        Next -> Node#list_node{val = Next#list_node.val, next = Next#list_node.next}
    end.
