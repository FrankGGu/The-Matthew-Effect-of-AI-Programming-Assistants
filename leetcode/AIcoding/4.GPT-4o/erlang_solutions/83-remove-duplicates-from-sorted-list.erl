%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec delete_duplicates(Head :: #list_node{} | null) -> #list_node{} | null.
delete_duplicates(null) -> null;
delete_duplicates(#list_node{val = Val, next = #list_node{val = ValNext} = Next}) ->
    delete_duplicates(Next);
delete_duplicates(Head) -> Head.
