%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec swap_pairs(Head :: #list_node{} | null) -> #list_node{} | null.
swap_pairs(null) -> null;
swap_pairs(#list_node{val = Val1, next = #list_node{val = Val2, next = Next}}) ->
    #list_node{val = Val2, next = #list_node{val = Val1, next = swap_pairs(Next)}}.
