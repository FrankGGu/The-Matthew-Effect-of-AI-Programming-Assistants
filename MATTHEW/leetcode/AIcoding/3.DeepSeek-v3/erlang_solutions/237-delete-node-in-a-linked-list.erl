-spec delete_node(Node :: #list_node{} | null) -> ok.
delete_node(Node) ->
    Next = Node#list_node.next,
    Node#list_node{val = Next#list_node.val, next = Next#list_node.next}.