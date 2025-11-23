%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec merge_two_lists(List1 :: #list_node{} | null, List2 :: #list_node{} | null) -> #list_node{} | null.
merge_two_lists(null, List2) -> List2;
merge_two_lists(List1, null) -> List1;
merge_two_lists(#list_node{val = Val1, next = Next1}, #list_node{val = Val2, next = Next2}) when Val1 =< Val2 ->
    #list_node{val = Val1, next = merge_two_lists(Next1, #list_node{val = Val2, next = Next2})};
merge_two_lists(#list_node{val = Val1, next = Next1}, #list_node{val = Val2, next = Next2}) when Val1 > Val2 ->
    #list_node{val = Val2, next = merge_two_lists(#list_node{val = Val1, next = Next1}, Next2)}.
