-record(list_node, {val, next}).

delete_node(Node) ->
    NextNode = Node#list_node.next,
    list_node:set_val(Node, NextNode#list_node.val),
    list_node:set_next(Node, NextNode#list_node.next),
    ok.