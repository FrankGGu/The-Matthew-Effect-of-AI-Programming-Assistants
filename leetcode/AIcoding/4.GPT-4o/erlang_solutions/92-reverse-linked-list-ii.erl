%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec reverse_between(Head :: #list_node{} | null, Left :: integer(), Right :: integer()) -> #list_node{} | null.
reverse_between(Head, Left, Right) when Left == 1 -> reverse_from_start(Head, Right);
reverse_between(Head, Left, Right) -> 
    reverse_between_helper(Head, Left - 1, Right - 1, null).

reverse_between_helper(null, _, _, _) -> null;
reverse_between_helper(#list_node{val = Val, next = Next}, 0, 0, Prev) ->
    #list_node{val = Val, next = Prev};
reverse_between_helper(#list_node{val = Val, next = Next}, Left, Right, Prev) ->
    NewNext = reverse_between_helper(Next, Left - 1, Right - 1, #list_node{val = Val, next = Prev}),
    case Right of
        0 -> NewNext;
        _ -> #list_node{val = Val, next = NewNext}
    end.

reverse_from_start(Head, 0) -> Head;
reverse_from_start(Head, N) -> 
    reverse_from_start(Head#list_node{next = Next}, N - 1).
