%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec reverse_k_group(Head :: #list_node{} | null, K :: integer()) -> #list_node{} | null.
reverse_k_group(Head, K) ->
    reverse_k_group(Head, K, null).

reverse_k_group(null, _, Prev) -> Prev;
reverse_k_group(Head, K, Prev) when K =< 1 -> reverse_k_group(Head#list_node{next = null}, K, Prev);
reverse_k_group(#list_node{val = Val, next = Next}, K, Prev) ->
    reverse_k_group(Next, K - 1, #list_node{val = Val, next = Prev}).
