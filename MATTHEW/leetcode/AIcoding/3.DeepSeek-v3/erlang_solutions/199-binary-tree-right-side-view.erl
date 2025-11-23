-spec right_side_view(Root :: #tree_node{} | null) -> [integer()].
right_side_view(Root) ->
    case Root of
        null -> [];
        _ -> right_side_view([Root], [])
    end.

right_side_view([], Acc) ->
    lists:reverse(Acc);
right_side_view(Level, Acc) ->
    {NextLevel, LastVal} = lists:foldl(
        fun(Node, {Nodes, _}) ->
            case Node#tree_node.left of
                null -> ok;
                Left -> Nodes = [Left | Nodes]
            end,
            case Node#tree_node.right of
                null -> ok;
                Right -> Nodes = [Right | Nodes]
            end,
            {Nodes, Node#tree_node.val}
        end,
        {[], undefined},
        Level
    ),
    right_side_view(lists:reverse(NextLevel), [LastVal | Acc]).