-spec rotate_right(Head :: #list_node{} | null, K :: integer()) -> #list_node{} | null.
rotate_right(null, _K) -> null;
rotate_right(Head, K) ->
    {Length, Tail} = get_length_and_tail(Head, 0, null),
    EffectiveK = K rem Length,
    case EffectiveK of
        0 -> Head;
        _ ->
            Steps = Length - EffectiveK,
            {NewHead, NewTail} = split_list(Head, Steps),
            Tail#list_node{next = Head},
            NewTail#list_node{next = null},
            NewHead
    end.

get_length_and_tail(null, Length, Tail) -> {Length, Tail};
get_length_and_tail(Node, Length, _Tail) ->
    get_length_and_tail(Node#list_node.next, Length + 1, Node).

split_list(Head, 0) -> {Head, null};
split_list(Node, Steps) ->
    case Steps =:= 1 of
        true ->
            Next = Node#list_node.next,
            Node#list_node{next = null},
            {Next, Node};
        false ->
            split_list(Node#list_node.next, Steps - 1)
    end.