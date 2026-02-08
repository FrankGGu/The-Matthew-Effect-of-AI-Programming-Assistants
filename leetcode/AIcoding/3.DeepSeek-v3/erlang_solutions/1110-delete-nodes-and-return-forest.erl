-spec del_nodes(Root :: #tree_node{} | null, To_delete :: [integer()]) -> [#tree_node{} | null].
del_nodes(Root, To_delete) ->
    Set = sets:from_list(To_delete),
    {Forest, _} = del_nodes(Root, Set, true),
    Forest.

del_nodes(null, _Set, _IsRoot) ->
    {[], false};
del_nodes(Node, Set, IsRoot) ->
    #tree_node{val = Val, left = Left, right = Right} = Node,
    ShouldDelete = sets:is_element(Val, Set),
    {LeftForest, LeftDeleted} = del_nodes(Left, Set, ShouldDelete),
    {RightForest, RightDeleted} = del_nodes(Right, Set, ShouldDelete),
    case ShouldDelete of
        true ->
            {LeftForest ++ RightForest, true};
        false ->
            NewNode = Node#tree_node{left = if LeftDeleted -> null; true -> Left end,
                                     right = if RightDeleted -> null; true -> Right end},
            case IsRoot of
                true -> {[NewNode | LeftForest ++ RightForest], false};
                false -> {LeftForest ++ RightForest, false}
            end
    end.