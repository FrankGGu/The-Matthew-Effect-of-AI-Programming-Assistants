-spec reverse_between(Head :: #list_node{} | null, Left :: integer(), Right :: integer()) -> #list_node{} | null.
reverse_between(Head, Left, Right) ->
    Dummy = #list_node{next = Head},
    Prev = Dummy,
    reverse_between_helper(Prev, Head, Left, Right, 1).

reverse_between_helper(Prev, Current, Left, Right, Pos) ->
    if
        Pos < Left ->
            reverse_between_helper(Current, Current#list_node.next, Left, Right, Pos + 1);
        Pos =:= Left ->
            Start = Prev,
            Tail = Current,
            {NewPrev, NewCurrent} = reverse(Start, Current, Right - Left + 1),
            Tail#list_node{next = NewCurrent},
            Start#list_node{next = NewPrev},
            Prev#list_node.next;
        true ->
            Current
    end.

reverse(Prev, Current, 0) ->
    {Prev, Current};
reverse(Prev, Current, N) ->
    Next = Current#list_node.next,
    NewCurrent = Current#list_node{next = Prev},
    reverse(NewCurrent, Next, N - 1).