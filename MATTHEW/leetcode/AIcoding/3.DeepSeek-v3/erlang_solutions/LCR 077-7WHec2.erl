-spec sort_list(Head :: #{} | null) -> #{} | null.
sort_list(null) -> null;
sort_list(Head) ->
    List = list_to_sort(Head, []),
    Sorted = lists:sort(fun(A, B) -> A =< B end, List),
    list_to_node(Sorted).

list_to_sort(null, Acc) -> Acc;
list_to_sort(Node, Acc) ->
    list_to_sort(maps:get(next, Node), [maps:get(val, Node) | Acc]).

list_to_node([]) -> null;
list_to_node([H | T]) ->
    #{val => H, next => list_to_node(T)}.