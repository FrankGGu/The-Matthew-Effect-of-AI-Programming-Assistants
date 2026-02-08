%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec partition(Head :: #list_node{} | null, X :: integer()) -> #list_node{} | null.
partition(Head, X) ->
    partition(Head, X, null, null).

partition(null, _, Less, Greater) -> 
    append(Less, Greater);
partition(#list_node{val = Val, next = Next}, X, Less, Greater) when Val < X -> 
    partition(Next, X, #list_node{val = Val, next = Less}, Greater);
partition(#list_node{val = Val, next = Next}, X, Less, Greater) -> 
    partition(Next, X, Less, #list_node{val = Val, next = Greater}).

append(null, List) -> List;
append(#list_node{val = Val, next = Next}, List) -> 
    #list_node{val = Val, next = append(Next, List)}.
