-record(list_node, {val, next}).

-spec has_cycle(Head :: list_node() | null) -> boolean().
has_cycle(Head) ->
    has_cycle_recursive(Head, Head).

has_cycle_recursive(Slow, Fast) ->
    case Fast of
        null ->
            false;
        #list_node{next = null} ->
            false;
        #list_node{} ->
            SlowNext = Slow#list_node.next,
            FastNext = Fast#list_node.next#list_node.next,
            if
                SlowNext == FastNext ->
                    true;
                true ->
                    has_cycle_recursive(SlowNext, FastNext)
            end
    end.