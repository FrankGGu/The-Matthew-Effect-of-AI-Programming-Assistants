-spec level_order(Root :: #tree_node{} | null) -> [[integer()]].
level_order(null) -> [];
level_order(Root) ->
    Q = queue:in(Root, queue:new()),
    level_order(Q, []).

level_order(Q, Acc) ->
    case queue:is_empty(Q) of
        true -> lists:reverse(Acc);
        false ->
            {Level, NewQ} = process_level(Q, [], queue:new()),
            level_order(NewQ, [Level | Acc])
    end.

process_level(Q, LevelAcc, NewQ) ->
    case queue:out(Q) of
        {empty, _} -> {LevelAcc, NewQ};
        {{value, Node}, RestQ} ->
            UpdatedLevelAcc = [Node#tree_node.val | LevelAcc],
            UpdatedNewQ = case Node#tree_node.left of
                null -> NewQ;
                Left -> queue:in(Left, NewQ)
            end,
            FinalNewQ = case Node#tree_node.right of
                null -> UpdatedNewQ;
                Right -> queue:in(Right, UpdatedNewQ)
            end,
            process_level(RestQ, UpdatedLevelAcc, FinalNewQ)
    end.