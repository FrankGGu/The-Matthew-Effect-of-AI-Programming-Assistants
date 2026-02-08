-module(solution).
-export([insert_into_circular_sorted_list/2]).

-record(node, {val, next}).

insert_into_circular_sorted_list(List, Val) ->
    NewNode = #node{val = Val},
    case List of
        none -> NewNode#node{next = NewNode};
        _ -> insert_helper(List, NewNode)
    end.

insert_helper(Current, NewNode) ->
    Next = Current#node.next,
    if
        NewNode#node.val < Current#node.val -> 
            NewNode#node{next = Current},
            Current#node{next = NewNode};
        NewNode#node.val >= Current#node.val, 
        (Next =:= Current; NewNode#node.val < Next#node.val) -> 
            NewNode#node{next = Next},
            Current#node{next = NewNode};
        true -> 
            insert_helper(Next, NewNode)
    end.