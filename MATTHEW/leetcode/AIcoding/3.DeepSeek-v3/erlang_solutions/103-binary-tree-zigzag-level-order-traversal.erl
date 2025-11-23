-spec zigzag_level_order(Root :: tree_node() | null) -> [[integer()]].
zigzag_level_order(null) -> [];
zigzag_level_order(Root) ->
    Queue = queue:in(Root, queue:new()),
    zigzag_level_order(Queue, [], false).

zigzag_level_order(Queue, Acc, Reverse) ->
    case queue:is_empty(Queue) of
        true -> lists:reverse(Acc);
        false ->
            {Level, NewQueue} = get_level(Queue, [], []),
            NewAcc = case Reverse of
                true -> [lists:reverse(Level) | Acc];
                false -> [Level | Acc]
            end,
            zigzag_level_order(NewQueue, NewAcc, not Reverse)
    end.

get_level(Queue, Level, NewQueue) ->
    case queue:out(Queue) of
        {empty, _} -> {Level, queue:from_list(lists:reverse(NewQueue))};
        {{value, Node}, Q} ->
            Left = case Node#tree_node.left of
                null -> [];
                L -> [L]
            end,
            Right = case Node#tree_node.right of
                null -> [];
                R -> [R]
            end,
            NewLevel = [Node#tree_node.val | Level],
            NewQ = lists:foldl(fun(X, QAcc) -> queue:in(X, QAcc) end, Q, Left ++ Right),
            get_level(NewQ, NewLevel, NewQueue)
    end.