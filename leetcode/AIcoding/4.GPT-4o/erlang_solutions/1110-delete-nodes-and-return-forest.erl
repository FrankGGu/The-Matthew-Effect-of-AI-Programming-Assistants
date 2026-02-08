-module(solution).
-export([del_nodes/2]).

-record(tree_node, {val, left, right}).

del_nodes(Root, To_delete) ->
    To_delete_set = sets:from_list(To_delete),
    del_nodes(Root, To_delete_set).

del_nodes(null, _) ->
    [];
del_nodes(Node, To_delete_set) ->
    case sets:is_element(Node#tree_node.val, To_delete_set) of
        true ->
            % Return children as new roots
            [del_nodes(Node#tree_node.left, To_delete_set),
             del_nodes(Node#tree_node.right, To_delete_set)];
        false ->
            NewLeft = del_nodes(Node#tree_node.left, To_delete_set),
            NewRight = del_nodes(Node#tree_node.right, To_delete_set),
            [Node#tree_node{left = hd(NewLeft), right = hd(NewRight)} | lists:tl(NewLeft) ++ lists:tl(NewRight)]
    end.