-spec reverse_even_length_groups(Head :: #list_node{} | null) -> #list_node{} | null.
reverse_even_length_groups(Head) ->
    case Head of
        null -> null;
        _ ->
            {NewHead, _} = reverse_groups(Head, 1),
            NewHead
    end.

reverse_groups(Head, K) ->
    case Head of
        null -> {null, 0};
        _ ->
            {GroupTail, NextHead, GroupLen} = split_group(Head, K, 0),
            case GroupLen rem 2 of
                0 ->
                    {ReversedHead, ReversedTail} = reverse_list(Head, GroupLen),
                    ReversedTail#list_node{next = null},
                    {NextReversedHead, NextK} = reverse_groups(NextHead, K + 1),
                    ReversedTail#list_node{next = NextReversedHead},
                    {ReversedHead, NextK};
                1 ->
                    GroupTail#list_node{next = null},
                    {NextReversedHead, NextK} = reverse_groups(NextHead, K + 1),
                    GroupTail#list_node{next = NextReversedHead},
                    {Head, NextK}
            end
    end.

split_group(Head, K, Len) ->
    case Head of
        null -> {null, null, Len};
        _ when Len =:= K -> {null, Head, Len};
        _ ->
            case Head#list_node.next of
                null -> {Head, null, Len + 1};
                Next ->
                    case split_group(Next, K, Len + 1) of
                        {null, NextHead, GroupLen} -> {Head, NextHead, GroupLen};
                        {Tail, NextHead, GroupLen} -> {Tail, NextHead, GroupLen}
                    end
            end
    end.

reverse_list(Head, Len) ->
    reverse_list(Head, Len, null).

reverse_list(Head, 0, Prev) -> {Prev, Head};
reverse_list(Head, Len, Prev) ->
    Next = Head#list_node.next,
    NewHead = Head#list_node{next = Prev},
    reverse_list(Next, Len - 1, NewHead).