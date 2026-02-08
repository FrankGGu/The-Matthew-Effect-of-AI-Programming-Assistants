-module(remove_nodes_from_linked_list).
-export([remove_nodes_from_linked_list/1]).

-record(list_node, {val, next}).

remove_nodes_from_linked_list(Head) ->
    remove_nodes_from_linked_list(Head, 0).

remove_nodes_from_linked_list(undefined, _) ->
    undefined;
remove_nodes_from_linked_list(#list_node{val = Val, next = Next}, Count) ->
    NewNext = remove_nodes_from_linked_list(Next, Count + 1),
    case Count of
        0 -> #list_node{val = Val, next = NewNext};
        _ -> NewNext
    end.