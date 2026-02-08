%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec is_palindrome(Head :: #list_node{} | null) -> boolean().
is_palindrome(Head) ->
    List = to_list(Head),
    List == lists:reverse(List).

to_list(null) -> [];
to_list(#list_node{val = Val, next = Next}) -> [Val | to_list(Next)].
