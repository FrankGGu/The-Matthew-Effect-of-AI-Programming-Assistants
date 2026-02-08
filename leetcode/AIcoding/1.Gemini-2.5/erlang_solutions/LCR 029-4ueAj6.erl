-record(node, {val, next}).

-spec insert(Head :: 'null' | #node{}, insertVal :: integer()) -> #node{}.
insert('null', InsertVal) ->
    NewNode = #node{val = InsertVal, next = undefined},
    NewNode#node.next = NewNode;
insert(Head, InsertVal) ->
    NewNode = #node{val = InsertVal, next = undefined},
    loop_and_insert(Head, Head#node.next, NewNode, Head).

loop_and_insert(Current, Next, NewNode, OriginalHead) ->
    CurrentVal = Current#node.val,
    NextVal = Next#node.val,

    ShouldInsert =
        (CurrentVal =< NewNode#node.val andalso NewNode#node.val =< NextVal) orelse
        (CurrentVal > NextVal andalso (NewNode#node.val >= CurrentVal orelse NewNode#node.val =< NextVal)),

    if
        ShouldInsert ->
            NewNode#node.next = Next,
            Current#node.next = NewNode,
            OriginalHead;
        Current == OriginalHead ->
            NewNode#node.next = Next,
            Current#node.next = NewNode,
            OriginalHead;
        true ->
            loop_and_insert(Next, Next#node.next, NewNode, OriginalHead)
    end.