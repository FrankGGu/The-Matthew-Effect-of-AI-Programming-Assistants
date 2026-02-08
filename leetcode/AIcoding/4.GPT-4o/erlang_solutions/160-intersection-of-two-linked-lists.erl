%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec get_intersection_node(HeadA :: #list_node{} | null, HeadB :: #list_node{} | null) -> #list_node{} | null.
get_intersection_node(HeadA, HeadB) ->
    get_intersection_node(HeadA, HeadB, HeadA, HeadB).

get_intersection_node(null, null, _, _) -> null;
get_intersection_node(null, HeadB, _, _) -> get_intersection_node(HeadB, null, HeadB, null);
get_intersection_node(HeadA, null, _, _) -> get_intersection_node(HeadA, null, HeadA, null);
get_intersection_node(#list_node{next = NextA} = HeadA, #list_node{next = NextB} = HeadB, OriginalA, OriginalB) ->
    case HeadA == HeadB of
        true -> HeadA;
        false -> get_intersection_node(NextA, NextB, OriginalA, OriginalB)
    end.
