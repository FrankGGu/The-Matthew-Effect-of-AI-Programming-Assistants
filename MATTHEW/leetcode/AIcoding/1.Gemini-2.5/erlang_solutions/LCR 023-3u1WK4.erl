-record(list_node, {val=0, next=null}).

-spec getIntersectionNode(headA :: #list_node{} | null, headB :: #list_node{} | null) -> #list_node{} | null.
getIntersectionNode(HeadA, HeadB) ->
    find_intersection(HeadA, HeadB, HeadA, HeadB).

find_intersection(PtrA, PtrB, OrigHeadA, OrigHeadB) ->
    if
        PtrA == PtrB ->
            PtrA;
        true ->
            NextA = case PtrA of
                        null -> OrigHeadB;
                        #list_node{next = N} -> N
                    end,
            NextB = case PtrB of
                        null -> OrigHeadA;
                        #list_node{next = N} -> N
                    end,
            find_intersection(NextA, NextB, OrigHeadA, OrigHeadB)
    end.