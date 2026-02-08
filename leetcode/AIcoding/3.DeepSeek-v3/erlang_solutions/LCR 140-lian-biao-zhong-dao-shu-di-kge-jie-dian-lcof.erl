-spec training_plan(Head :: #list_node{} | null, Cnt :: integer()) -> #list_node{} | null.
training_plan(Head, Cnt) ->
    {Fast, Slow} = move_fast_slow(Head, Cnt),
    Slow.

move_fast_slow(Head, Cnt) ->
    Fast = Head,
    Slow = Head,
    move_fast_slow(Fast, Slow, Cnt).

move_fast_slow(Fast, Slow, 0) ->
    {Fast, Slow};
move_fast_slow(null, Slow, _Cnt) ->
    {null, Slow};
move_fast_slow(#list_node{next = Next}, Slow, Cnt) when Cnt > 0 ->
    move_fast_slow(Next, Slow, Cnt - 1);
move_fast_slow(Fast, #list_node{next = Next}, Cnt) when Cnt =:= 0 ->
    move_fast_slow(Fast#list_node.next, Next, 0).