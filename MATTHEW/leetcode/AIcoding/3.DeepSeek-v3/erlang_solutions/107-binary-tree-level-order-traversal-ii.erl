-spec level_order_bottom(Root :: #tree_node{} | null) -> [[integer()]].
level_order_bottom(null) -> [];
level_order_bottom(Root) ->
    Queue = [{Root, 0}],
    traverse(Queue, []).

traverse([], Acc) ->
    lists:reverse(Acc);
traverse([{null, _} | Rest], Acc) ->
    traverse(Rest, Acc);
traverse([{Node, Level} | Rest], Acc) ->
    NewAcc = case length(Acc) > Level of
        true -> 
            [lists:nth(1, Acc) ++ [Node#tree_node.val] | lists:nthtail(1, Acc)];
        false -> 
            [[Node#tree_node.val] | Acc]
    end,
    Left = Node#tree_node.left,
    Right = Node#tree_node.right,
    NewRest = Rest ++ [{Left, Level + 1}, {Right, Level + 1}],
    traverse(NewRest, NewAcc).