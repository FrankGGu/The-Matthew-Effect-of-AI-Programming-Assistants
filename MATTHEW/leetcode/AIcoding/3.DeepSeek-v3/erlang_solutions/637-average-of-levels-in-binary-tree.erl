-spec average_of_levels(Root :: #tree_node{} | null) -> [float()].
average_of_levels(null) -> [];
average_of_levels(Root) ->
    Q = queue:in(Root, queue:new()),
    bfs(Q, []).

bfs(Q, Acc) ->
    case queue:is_empty(Q) of
        true -> lists:reverse(Acc);
        false ->
            {LevelSum, LevelCount, NewQ} = process_level(Q, 0, 0, queue:new()),
            bfs(NewQ, [LevelSum / LevelCount | Acc])
    end.

process_level(Q, Sum, Count, NewQ) ->
    case queue:out(Q) of
        {empty, _} -> {Sum, Count, NewQ};
        {{value, Node}, RestQ} ->
            NewSum = Sum + Node#tree_node.val,
            NewCount = Count + 1,
            UpdatedQ = case Node#tree_node.left of
                null -> NewQ;
                Left -> queue:in(Left, NewQ)
            end,
            FinalQ = case Node#tree_node.right of
                null -> UpdatedQ;
                Right -> queue:in(Right, UpdatedQ)
            end,
            process_level(RestQ, NewSum, NewCount, FinalQ)
    end.