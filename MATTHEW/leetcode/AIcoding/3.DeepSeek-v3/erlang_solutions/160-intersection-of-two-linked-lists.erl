-spec get_intersection_node(HeadA :: #list_node{} | null, HeadB :: #list_node{} | null) -> #list_node{} | null.
get_intersection_node(HeadA, HeadB) ->
    case {HeadA, HeadB} of
        {null, null} -> null;
        _ ->
            A = HeadA,
            B = HeadB,
            get_intersection(A, B, A, B)
    end.

get_intersection(null, null, _, _) -> null;
get_intersection(null, B, A, _) -> get_intersection(A, B#list_node.next, A, B#list_node.next);
get_intersection(A, null, _, B) -> get_intersection(A#list_node.next, B, A#list_node.next, B);
get_intersection(A, B, _, _) ->
    if
        A =:= B -> A;
        true -> get_intersection(A#list_node.next, B#list_node.next, A#list_node.next, B#list_node.next)
    end.