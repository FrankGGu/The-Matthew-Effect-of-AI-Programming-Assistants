-spec sort_list(Head :: #list_node{} | null) -> #list_node{} | null.
sort_list(null) -> null;
sort_list(Head) ->
    List = list_to_list(Head),
    SortedList = lists:sort(fun(A, B) -> A =< B end, List),
    list_to_listnode(SortedList).

list_to_list(null) -> [];
list_to_list(#list_node{val = Val, next = Next}) ->
    [Val | list_to_list(Next)].

list_to_listnode([]) -> null;
list_to_listnode([H | T]) ->
    #list_node{val = H, next = list_to_listnode(T)}.