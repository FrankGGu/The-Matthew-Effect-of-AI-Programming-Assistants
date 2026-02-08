%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec rotate_right(Head :: #list_node{} | null, K :: integer()) -> #list_node{} | null.
rotate_right(Head, K) when K > 0 ->
    {Len, Last} = length_and_last(Head),
    K = K rem Len,
    rotate_right(Head, K, Last, 0).

rotate_right(Head, 0, _, _) -> Head;
rotate_right(#list_node{next = null}, _, _, _) -> Head;
rotate_right(Head, K, Last, _) when K > 0 ->
    rotate_right(Head#list_node{next = Last}, K - 1, Last, 0).

length_and_last(null) -> {0, null};
length_and_last(#list_node{next = Next, val = _}) -> {Len, Last} = length_and_last(Next), {Len + 1, Last}.
