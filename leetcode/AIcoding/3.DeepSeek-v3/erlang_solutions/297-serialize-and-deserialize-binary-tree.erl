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
                    NewAcc = [integer_to_list(Node#tree_node.val) | Acc],
                    NewQ = queue:in(Right, queue:in(Left, Q)),
                    serialize_helper(NewQ, NewAcc)
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
            deserialize_helper(T, Queue)
    end.

deserialize_helper([], Queue) ->
    case queue:is_empty(Queue) of
        true -> undefined;
        false -> 
            {{value, Node}, _} = queue:out(Queue),
            Node
    end;
deserialize_helper(Data, Queue) ->
    {{value, Node}, Q} = queue:out(Queue),
    [LeftVal | Rest1] = Data,
    Left = case LeftVal of
        "null" -> null;
        _ -> 
            LeftNode = #tree_node{val = list_to_integer(LeftVal)},
            queue:in(LeftNode, Q),
            LeftNode
    end,
    Node1 = Node#tree_node{left = Left},
    case Rest1 of
        [] -> Node1;
        [RightVal | Rest2] ->
            Right = case RightVal of
                "null" -> null;
                _ ->
                    RightNode = #tree_node{val = list_to_integer(RightVal)},
                    queue:in(RightNode, Q),
                    RightNode
            end,
            Node2 = Node1#tree_node{right = Right},
            deserialize_helper(Rest2, Q)
    end.