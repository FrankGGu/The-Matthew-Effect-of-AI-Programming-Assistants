-record('ListNode', {val=0, next=nil}).

-spec remove_nth_from_end(Head :: #'ListNode'{} | nil, N :: integer()) -> #'ListNode'{} | nil.
remove_nth_from_end(Head, N) ->
    Length = get_length(Head, 0),
    IndexToRemove = Length - N + 1,
    ValuesList = collect_values_recursive(Head, IndexToRemove, 1, []),
    list_to_nodes(ValuesList).

get_length(nil, Acc) -> Acc;
get_length(#'ListNode'{next=Next}, Acc) -> get_length(Next, Acc + 1).

collect_values_recursive(nil, _IndexToRemove, _CurrentIndex, Acc) -> lists:reverse(Acc);
collect_values_recursive(#'ListNode'{val=Val, next=Next}, IndexToRemove, CurrentIndex, Acc) ->
    if CurrentIndex =:= IndexToRemove ->
        collect_values_recursive(Next, IndexToRemove, CurrentIndex + 1, Acc);
    true ->
        collect_values_recursive(Next, IndexToRemove, CurrentIndex + 1, [Val | Acc])
    end.

list_to_nodes([]) -> nil;
list_to_nodes([H|T]) -> #'ListNode'{val=H, next=list_to_nodes(T)}.