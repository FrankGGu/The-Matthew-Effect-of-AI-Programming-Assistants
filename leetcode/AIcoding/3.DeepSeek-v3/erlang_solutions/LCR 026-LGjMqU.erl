-spec reorder_list(Head :: #list_node{} | null) -> ok.
reorder_list(null) -> ok;
reorder_list(Head) ->
    {First, Second} = split_list(Head),
    SecondReversed = reverse_list(Second),
    merge_lists(First, SecondReversed).

split_list(Head) ->
    Slow = Head,
    Fast = Head,
    split_list(Slow, Fast, Head).

split_list(Slow, Fast, Prev) when Fast == null; Fast#list_node.next == null ->
    Second = Slow#list_node.next,
    Slow#list_node.next = null,
    {Prev, Second};
split_list(Slow, Fast, Prev) ->
    NewFast = Fast#list_node.next,
    if 
        NewFast /= null ->
            split_list(Slow#list_node.next, NewFast#list_node.next, Slow);
        true ->
            split_list(Slow#list_node.next, NewFast, Slow)
    end.

reverse_list(Head) ->
    reverse_list(Head, null).

reverse_list(null, Prev) -> Prev;
reverse_list(Head, Prev) ->
    Next = Head#list_node.next,
    Head#list_node.next = Prev,
    reverse_list(Next, Head).

merge_lists(null, null) -> ok;
merge_lists(First, null) -> ok;
merge_lists(null, Second) -> ok;
merge_lists(First, Second) ->
    FirstNext = First#list_node.next,
    SecondNext = Second#list_node.next,
    First#list_node.next = Second,
    Second#list_node.next = FirstNext,
    merge_lists(FirstNext, SecondNext).