-spec remove_nth_from_end(Head :: #list_node{} | null, N :: integer()) -> #list_node{} | null.
remove_nth_from_end(Head, N) ->
    Dummy = #list_node{next = Head},
    Fast = Dummy,
    Slow = Dummy,
    {Fast1, Slow1} = move_fast(Fast, Slow, N),
    {_, Slow2} = move_both(Fast1, Slow1),
    Slow2#list_node{next = Slow2#list_node.next#list_node.next},
    Dummy#list_node.next.

move_fast(Fast, Slow, N) when N > 0 ->
    move_fast(Fast#list_node.next, Slow, N - 1);
move_fast(Fast, Slow, 0) ->
    {Fast, Slow}.

move_both(Fast, Slow) when Fast#list_node.next =/= null ->
    move_both(Fast#list_node.next, Slow#list_node.next);
move_both(Fast, Slow) ->
    {Fast, Slow}.