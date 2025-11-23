-spec delete_duplicates(Head :: #list_node{} | null) -> #list_node{} | null.
delete_duplicates(Head) ->
    Dummy = #list_node{next = Head},
    Prev = Dummy,
    Current = Head,
    delete_duplicates_helper(Prev, Current),
    Dummy#list_node.next.

delete_duplicates_helper(Prev, null) ->
    Prev;
delete_duplicates_helper(Prev, Current) ->
    case is_duplicate(Current) of
        true ->
            {Val, Next} = skip_duplicates(Current),
            Prev#list_node.next = Next,
            delete_duplicates_helper(Prev, Next);
        false ->
            Prev#list_node.next = Current,
            delete_duplicates_helper(Current, Current#list_node.next)
    end.

is_duplicate(null) -> false;
is_duplicate(#list_node{next = null}) -> false;
is_duplicate(#list_node{val = Val, next = #list_node{val = Val}}) -> true;
is_duplicate(_) -> false.

skip_duplicates(Node) ->
    Val = Node#list_node.val,
    skip_duplicates_helper(Val, Node).

skip_duplicates_helper(Val, #list_node{val = Val, next = Next}) ->
    skip_duplicates_helper(Val, Next);
skip_duplicates_helper(_, Node) ->
    Node.