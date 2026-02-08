-module(delete_nodes_from_linked_list_present_in_array).
-export([deleteNodes/2]).

-record(list_node, {val, next}).

deleteNodes(Head, B) ->
    Set = sets:from_list(B),
    deleteNodes(Head, Set, null).

deleteNodes(null, _, _) ->
    null;
deleteNodes(#list_node{val = Val, next = Next}, Set, Prev) ->
    case sets:is_element(Val, Set) of
        true ->
            case Prev of
                null ->
                    deleteNodes(Next, Set, null);
                _ ->
                    Prev#list_node{next = Next},
                    deleteNodes(Next, Set, Prev)
            end;
        false ->
            deleteNodes(Next, Set, #list_node{val = Val, next = null})
    end.