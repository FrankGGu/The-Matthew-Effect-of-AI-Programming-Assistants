-spec is_complete_tree(Root :: #tree_node{} | null) -> boolean().
is_complete_tree(Root) ->
    case Root of
        null -> true;
        _ ->
            Q = queue:in(Root, queue:new()),
            check(Q, false)
    end.

check(Q, SeenNull) ->
    case queue:out(Q) of
        {empty, _} -> true;
        {{value, Node}, Q1} ->
            case Node of
                null ->
                    if SeenNull -> false;
                       true -> check(Q1, true)
                    end;
                #tree_node{left = Left, right = Right} ->
                    Q2 = queue:in(Left, queue:in(Right, Q1)),
                    check(Q2, SeenNull)
            end
    end.