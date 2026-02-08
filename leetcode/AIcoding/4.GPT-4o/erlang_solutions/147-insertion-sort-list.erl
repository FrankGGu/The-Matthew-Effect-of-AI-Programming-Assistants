%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec insertion_sort_list(Head :: #list_node{} | null) -> #list_node{} | null.
insertion_sort_list(null) -> null;
insertion_sort_list(Head) -> 
    insertion_sort_list(Head, null).

-spec insertion_sort_list(#list_node{}, #list_node{}) -> #list_node{}.
insertion_sort_list(null, Sorted) -> Sorted;
insertion_sort_list(#list_node{val = Val, next = Next}, Sorted) ->
    SortedRest = insert(Val, Sorted),
    insertion_sort_list(Next, SortedRest).

-spec insert(Integer, #list_node{} | null) -> #list_node{}.
insert(Val, null) -> #list_node{val = Val, next = null};
insert(Val, #list_node{val = HeadVal, next = Next} = Head) when Val <= HeadVal -> 
    #list_node{val = Val, next = Head};
insert(Val, #list_node{val = HeadVal, next = Next}) ->
    Head#list_node{next = insert(Val, Next)}.
