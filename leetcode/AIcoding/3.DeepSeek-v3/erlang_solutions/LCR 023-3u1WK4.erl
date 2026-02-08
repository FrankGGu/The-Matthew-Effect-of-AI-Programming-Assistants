-spec get_intersection_node(HeadA :: #list_node{} | null, HeadB :: #list_node{} | null) -> #list_node{} | null.
get_intersection_node(HeadA, HeadB) ->
    case {HeadA, HeadB} of
        {null, null} -> null;
        _ ->
            A = HeadA,
            B = HeadB,
            get_intersection_node(A, B, A, B)
    end.

get_intersection_node(null, null, _, _)
    null;
get_intersection_node(A, B, OriginalA, OriginalB) ->
    if
        A =:= B -> A;
        true ->
            NextA = if
                A =:= null -> OriginalB;
                true -> A#list_node.next
            end,
            NextB = if
                B =:= null -> OriginalA;
                true -> B#list_node.next
            end,
            get_intersection_node(NextA, NextB, OriginalA, OriginalB)
    end.