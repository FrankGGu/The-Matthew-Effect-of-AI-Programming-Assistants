%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec odd_even_list(Head :: #list_node{} | null) -> #list_node{} | null.
odd_even_list(Head) ->
    odd_even_list(Head, null, null).

odd_even_list(null, _, _) -> null;
odd_even_list(#list_node{val = Val, next = null}, Even, Odd) ->
    Odd;
odd_even_list(#list_node{val = Val, next = Next}, Even, Odd) ->
    odd_even_list(Next, Odd, #list_node{val = Val, next = Even}).
