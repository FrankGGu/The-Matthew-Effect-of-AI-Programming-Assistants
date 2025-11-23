-record(node, {val :: integer(),
               next :: #node{} | null}).

-spec insert(Node :: #node{} | null, InsertVal :: integer()) -> #node{} | null.
insert(Node, InsertVal) ->
    case Node of
        null ->
            NewNode = #node{val = InsertVal},
            NewNode#node{next = NewNode};
        _ ->
            insert(Node, Node, InsertVal)
    end.

insert(Current, Head, InsertVal) ->
    Next = Current#node.next,
    case should_insert(Current, Next, InsertVal) of
        true ->
            NewNode = #node{val = InsertVal, next = Next},
            Current#node{next = NewNode},
            Head;
        false ->
            if
                Next =:= Head ->
                    NewNode = #node{val = InsertVal, next = Next},
                    Current#node{next = NewNode},
                    Head;
                true ->
                    insert(Next, Head, InsertVal)
            end
    end.

should_insert(Current, Next, InsertVal) ->
    (Current#node.val =< InsertVal andalso InsertVal =< Next#node.val) orelse
    (Current#node.val > Next#node.val andalso (InsertVal >= Current#node.val orelse InsertVal =< Next#node.val)).