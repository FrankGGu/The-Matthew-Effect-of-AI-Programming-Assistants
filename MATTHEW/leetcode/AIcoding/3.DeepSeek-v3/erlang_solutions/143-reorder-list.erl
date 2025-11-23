-spec reorder_list(Head :: #list_node{} | null) -> ok.
reorder_list(null) -> ok;
reorder_list(Head) ->
    {First, Second} = split_list(Head),
    SecondReversed = reverse_list(Second),
    merge_lists(First, SecondReversed).

split_list(Head) ->
    Slow = Head,
    Fast = Head,
    split_list(Slow, Fast).

split_list(Slow, #list_node{next = null}) ->
    {Slow, null};
split_list(Slow, #list_node{next = #list_node{next = null}}) ->
    Next = Slow#list_node.next,
    Slow#list_node.next = null,
    {Slow, Next};
split_list(Slow, #list_node{next = #list_node{next = FastNext}}) ->
    split_list(Slow#list_node.next, FastNext).

reverse_list(Head) ->
    reverse_list(Head, null).

reverse_list(null, Prev) -> Prev;
reverse_list(Node, Prev) ->
    Next = Node#list_node.next,
    Node#list_node.next = Prev,
    reverse_list(Next, Node).

merge_lists(null, null) -> ok;
merge_lists(First, null) -> ok;
merge_lists(null, Second) -> ok;
merge_lists(First, Second) ->
    FirstNext = First#list_node.next,
    SecondNext = Second#list_node.next,
    First#list_node.next = Second,
    Second#list_node.next = FirstNext,
    merge_lists(FirstNext, SecondNext).