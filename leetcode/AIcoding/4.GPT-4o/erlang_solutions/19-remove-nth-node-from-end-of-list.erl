-spec remove_nth_from_end(Head :: #list_node{} | null, N :: integer()) -> #list_node{} | null.
remove_nth_from_end(Head, N) ->
    remove_nth_from_end(Head, N, Head).

remove_nth_from_end(null, _, _) -> null;
remove_nth_from_end(#list_node{next = null}, 1, _) -> null;
remove_nth_from_end(#list_node{val = Val, next = Next}, N, Head) when N > 1 ->
    remove_nth_from_end(Next, N - 1, Head);
remove_nth_from_end(#list_node{val = _, next = Next}, 1, #list_node{next = NextNext}) ->
    NextNext.