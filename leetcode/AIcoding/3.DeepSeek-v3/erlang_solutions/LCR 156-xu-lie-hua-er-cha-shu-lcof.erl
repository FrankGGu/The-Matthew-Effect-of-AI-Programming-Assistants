-spec serialize(undefined | #tree_node{}) -> list().
serialize(Root) ->
    case Root of
        undefined -> ["null"];
        _ -> 
            Queue = queue:in(Root, queue:new()),
            serialize_helper(Queue, [])
    end.

serialize_helper(Queue, Acc) ->
    case queue:is_empty(Queue) of
        true -> lists:reverse(Acc);
        false ->
            {{value, Node}, Q} = queue:out(Queue),
            case Node of
                null -> 
                    serialize_helper(Q, ["null" | Acc]);
                _ ->
                    Left = case Node#tree_node.left of
                        undefined -> null;
                        L -> L
                    end,
                    Right = case Node#tree_node.right of
                        undefined -> null;
                        R -> R
                    end,
                    NewQ = queue:in(Left, queue:in(Right, Q)),
                    serialize_helper(NewQ, [integer_to_list(Node#tree_node.val) | Acc])
            end
    end.

-spec deserialize(list()) -> undefined | #tree_node{}.
deserialize(Data) ->
    case Data of
        [] -> undefined;
        ["null"] -> undefined;
        _ ->
            [H | T] = Data,
            Root = #tree_node{val = list_to_integer(H)},
            Queue = queue:in(Root, queue:new()),
            deserialize_helper(T, Queue),
            Root
    end.

deserialize_helper([], _) -> ok;
deserialize_helper(Data, Queue) ->
    {{value, Parent}, Q} = queue:out(Queue),
    case Data of
        [] -> ok;
        ["null" | Rest] ->
            Parent1 = Parent#tree_node{left = undefined},
            deserialize_helper(Rest, Q);
        [LeftVal | Rest1] ->
            Left = #tree_node{val = list_to_integer(LeftVal)},
            Parent1 = Parent#tree_node{left = Left},
            Q1 = queue:in(Left, Q),
            case Rest1 of
                [] -> ok;
                ["null" | Rest2] ->
                    Parent2 = Parent1#tree_node{right = undefined},
                    deserialize_helper(Rest2, Q1);
                [RightVal | Rest2] ->
                    Right = #tree_node{val = list_to_integer(RightVal)},
                    Parent2 = Parent1#tree_node{right = Right},
                    Q2 = queue:in(Right, Q1),
                    deserialize_helper(Rest2, Q2)
            end
    end.