-spec has_cycle(Head :: #list_node{} | null) -> boolean().
has_cycle(null) -> false;
has_cycle(Head) ->
    has_cycle(Head, Head).

has_cycle(Slow, Fast) when Fast =:= null; Fast#list_node.next =:= null -> false;
has_cycle(Slow, Fast) ->
    SlowNext = Slow#list_node.next,
    FastNext = Fast#list_node.next#list_node.next,
    if
        SlowNext =:= FastNext -> true;
        true -> has_cycle(SlowNext, FastNext)
    end.