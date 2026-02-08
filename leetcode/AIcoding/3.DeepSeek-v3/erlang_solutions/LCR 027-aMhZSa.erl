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
    find_middle(Head, Head, Head).

find_middle(Slow, Fast, _) when Fast == null; Fast#list_node.next == null ->
    {Slow, Fast};
find_middle(Slow, Fast, Prev) ->
    find_middle(Slow#list_node.next, Fast#list_node.next#list_node.next, Slow).

reverse(Node) ->
    reverse(Node, null).

reverse(Node, Prev) ->
    case Node of
        null -> Prev;
        _ ->
            Next = Node#list_node.next,
            Node1 = Node#list_node{next = Prev},
            reverse(Next, Node1)
    end.

compare(null, _) -> true;
compare(_, null) -> true;
compare(A, B) when A#list_node.val == B#list_node.val ->
    compare(A#list_node.next, B#list_node.next);
compare(_, _) -> false.