-spec training_plan(Head :: #list_node{} | null) -> #list_node{} | null.
training_plan(Head) ->
    case Head of
        null -> null;
        _ ->
            List = to_list(Head, []),
            Reversed = lists:reverse(List),
            to_list_node(Reversed)
    end.

to_list(null, Acc) -> Acc;
to_list(Node, Acc) ->
    to_list(Node#list_node.next, [Node#list_node.val | Acc]).

to_list_node([]) -> null;
to_list_node([H | T]) ->
    #list_node{val = H, next = to_list_node(T)}.