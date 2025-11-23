-spec decorate_record(TreeNode :: #{} | null) -> [[integer()]].
decorate_record(Root) ->
    case Root of
        null -> [];
        _ -> decorate(Root)
    end.

decorate(Root) ->
    Q = queue:in(Root, queue:new()),
    decorate(Q, [], true).

decorate(Q, Acc, LeftToRight) ->
    case queue:is_empty(Q) of
        true -> lists:reverse(Acc);
        false ->
            {Level, NewQ} = get_level(Q, [], queue:new()),
            decorate(NewQ, [format_level(Level, LeftToRight) | Acc], not LeftToRight)
    end.

get_level(Q, Level, NewQ) ->
    case queue:out(Q) of
        {empty, _} -> {Level, NewQ};
        {{value, Node}, Q1} ->
            NewLevel = [maps:get(val, Node) | Level],
            NewQ2 = case maps:get(left, Node, null) of
                null -> NewQ;
                Left -> queue:in(Left, NewQ)
            end,
            NewQ3 = case maps:get(right, Node, null) of
                null -> NewQ2;
                Right -> queue:in(Right, NewQ2)
            end,
            get_level(Q1, NewLevel, NewQ3)
    end.

format_level(Level, true) -> Level;
format_level(Level, false) -> lists:reverse(Level).