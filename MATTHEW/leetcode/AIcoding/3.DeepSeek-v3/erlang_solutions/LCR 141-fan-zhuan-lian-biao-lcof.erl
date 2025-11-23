-spec training_plan(Head :: #list_node{} | null) -> #list_node{} | null.
training_plan(Head) ->
    case Head of
        null -> null;
        _ ->
            Prev = null,
            Current = Head,
            reverse(Prev, Current)
    end.

reverse(Prev, null) -> Prev;
reverse(Prev, Current) ->
    Next = Current#list_node.next,
    NewCurrent = Current#list_node{next = Prev},
    reverse(NewCurrent, Next).