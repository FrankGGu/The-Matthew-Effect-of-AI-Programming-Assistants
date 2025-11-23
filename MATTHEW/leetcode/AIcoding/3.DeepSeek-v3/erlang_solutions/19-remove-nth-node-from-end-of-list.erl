-spec remove_nth_from_end(Head :: #list_node{} | null, N :: integer()) -> #list_node{} | null.
remove_nth_from_end(Head, N) ->
    Dummy = #list_node{next = Head},
    First = Dummy,
    Second = Dummy,
    {First1, Second1} = move_first(First, Second, N),
    {First2, Second2} = move_both(First1, Second1),
    remove_node(Second2),
    Dummy#list_node.next.

move_first(First, Second, N) when N > 0 ->
    move_first(First#list_node.next, Second, N - 1);
move_first(First, Second, 0) ->
    {First, Second}.

move_both(First, Second) when First#list_node.next =/= null ->
    move_both(First#list_node.next, Second#list_node.next);
move_both(First, Second) ->
    {First, Second}.

remove_node(Prev) ->
    Prev#list_node{next = (Prev#list_node.next)#list_node.next}.