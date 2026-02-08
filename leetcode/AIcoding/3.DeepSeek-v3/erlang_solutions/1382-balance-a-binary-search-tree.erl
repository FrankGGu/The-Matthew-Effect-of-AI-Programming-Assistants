-spec balance_bst(#tree_node{} | null) -> #tree_node{} | null.
balance_bst(Root) ->
    case Root of
        null -> null;
        _ ->
            Nodes = in_order(Root, []),
            build_balanced_bst(Nodes, 0, length(Nodes) - 1)
    end.

in_order(null, Acc) -> Acc;
in_order(#tree_node{left = Left, val = Val, right = Right}, Acc) ->
    Acc1 = in_order(Left, Acc),
    Acc2 = [Val | Acc1],
    in_order(Right, Acc2).

build_balanced_bst(Nodes, Start, End) when Start > End -> null;
build_balanced_bst(Nodes, Start, End) ->
    Mid = (Start + End) div 2,
    #tree_node{
        val = lists:nth(Mid + 1, Nodes),
        left = build_balanced_bst(Nodes, Start, Mid - 1),
        right = build_balanced_bst(Nodes, Mid + 1, End)
    }.