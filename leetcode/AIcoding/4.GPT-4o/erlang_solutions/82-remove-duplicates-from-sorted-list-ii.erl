%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec delete_duplicates(Head :: #list_node{} | null) -> #list_node{} | null.
delete_duplicates(null) -> null;
delete_duplicates(#list_node{val = Val, next = null}) -> #list_node{val = Val, next = null};
delete_duplicates(#list_node{val = Val, next = Next}) ->
    delete_duplicates(Val, Next, null).

delete_duplicates(_, null, Prev) -> Prev;
delete_duplicates(PrevVal, #list_node{val = Val, next = Next}, Prev) when PrevVal =:= Val ->
    delete_duplicates(PrevVal, Next, Prev);
delete_duplicates(_, #list_node{val = Val, next = Next}, Prev) ->
    delete_duplicates(Val, Next, #list_node{val = Val, next = Prev}).

delete_duplicates(_, null, _) -> null.
