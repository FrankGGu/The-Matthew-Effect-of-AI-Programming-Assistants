-spec serialize_init_(Root :: #tree_node{} | null) -> list().
serialize_init_(null) ->
    [];
serialize_init_(Root) ->
    serialize([Root], []).

serialize([], Acc) ->
    lists:reverse(Acc);
serialize([null | Rest], Acc) ->
    serialize(Rest, [null | Acc]);
serialize([#tree_node{val = Val, left = Left, right = Right} | Rest], Acc) ->
    serialize(Rest ++ [Left, Right], [Val | Acc]).

-spec deserialize_init_(Data :: list()) -> #tree_node{} | null.
deserialize_init_([]) ->
    null;
deserialize_init_(Data) ->
    [Val | Rest] = Data,
    deserialize(#tree_node{val = Val}, Rest).

deserialize(Node, []) ->
    Node;
deserialize(Node, [null | Rest]) ->
    Node;
deserialize(Node, [Val | Rest]) when is_integer(Val) ->
    NewNode = #tree_node{val = Val},
    case Node of
        #tree_node{left = null} ->
            deserialize(Node#tree_node{left = NewNode}, Rest);
        #tree_node{right = null} ->
            deserialize(Node#tree_node{right = NewNode}, Rest);
        _ ->
            deserialize(Node, Rest)
    end;
deserialize(Node, [null | Rest]) ->
    case Node of
        #tree_node{left = null} ->
            deserialize(Node#tree_node{left = null}, Rest);
        #tree_node{right = null} ->
            deserialize(Node#tree_node{right = null}, Rest);
        _ ->
            deserialize(Node, Rest)
    end.