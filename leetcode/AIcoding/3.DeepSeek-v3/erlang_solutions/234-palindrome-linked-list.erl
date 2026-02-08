-spec is_palindrome(Head :: #list_node{} | null) -> boolean().
is_palindrome(Head) ->
    case Head of
        null -> true;
        _ ->
            {Slow, Fast} = find_middle(Head),
            SecondHalf = reverse(Slow),
            compare(Head, SecondHalf)
    end.

find_middle(Head) ->
    find_middle(Head, Head).

find_middle(Slow, Fast) ->
    case Fast of
        null -> {Slow, null};
        #list_node{next = null} -> {Slow, null};
        #list_node{next = NextFast} ->
            case NextFast of
                null -> {Slow, null};
                _ -> find_middle(Slow#list_node.next, NextFast#list_node.next)
            end
    end.

reverse(Head) ->
    reverse(Head, null).

reverse(Head, Prev) ->
    case Head of
        null -> Prev;
        _ ->
            Next = Head#list_node.next,
            NewHead = Head#list_node{next = Prev},
            reverse(Next, NewHead)
    end.

compare(null, _) -> true;
compare(_, null) -> true;
compare(#list_node{val = Val1}, #list_node{val = Val2}) ->
    if
        Val1 =:= Val2 -> compare(#list_node.next, #list_node.next);
        true -> false
    end.