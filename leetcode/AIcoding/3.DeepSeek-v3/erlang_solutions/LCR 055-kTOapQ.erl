-spec bst_iterator_init_(Root :: #tree_node{} | null) -> any().
bst_iterator_init_(null) ->
    {[], []};
bst_iterator_init_(Root) ->
    {[Root], []}.

-spec bst_iterator_next_(State :: any()) -> {integer(), any()}.
bst_iterator_next_({[], []}) ->
    {0, {[], []}};
bst_iterator_next_({Stack, Visited}) ->
    {Node, NewStack} = case Stack of
        [H|T] -> {H, T};
        [] -> {null, []}
    end,
    case Node of
        null ->
            bst_iterator_next_({NewStack, Visited});
        #tree_node{left = null, right = Right, val = Val} ->
            NewVisited = [Node|Visited],
            NewStack1 = case Right of
                null -> NewStack;
                _ -> [Right|NewStack]
            end,
            {Val, {NewStack1, NewVisited}};
        #tree_node{left = Left, right = Right, val = Val} ->
            case lists:member(Node, Visited) of
                true ->
                    NewVisited = Visited,
                    NewStack1 = case Right of
                        null -> NewStack;
                        _ -> [Right|NewStack]
                    end,
                    {Val, {NewStack1, NewVisited}};
                false ->
                    NewVisited = [Node|Visited],
                    NewStack1 = [Node|NewStack],
                    NewStack2 = case Left of
                        null -> NewStack1;
                        _ -> [Left|NewStack1]
                    end,
                    bst_iterator_next_({NewStack2, NewVisited})
            end
    end.

-spec bst_iterator_has_next_(State :: any()) -> boolean().
bst_iterator_has_next_({[], []}) ->
    false;
bst_iterator_has_next_({Stack, _Visited}) ->
    Stack /= [].