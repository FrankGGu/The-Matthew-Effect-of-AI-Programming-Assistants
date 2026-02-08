-spec serialize( Root :: #tree_node{} | null ) -> list().
serialize(null) ->
    [];
serialize(Root) ->
    serialize([Root], []).

serialize([], Acc) ->
    lists:reverse(Acc);
serialize([null | Rest], Acc) ->
    serialize(Rest, [null | Acc]);
serialize([#tree_node{val = Val, left = Left, right = Right} | Rest], Acc) ->
    serialize(Rest ++ [Right, Left], [Val | Acc]).

-spec deserialize( Data :: list() ) -> #tree_node{} | null.
deserialize([]) ->
    null;
deserialize(Data) ->
    {Root, []} = deserialize(Data, null),
    Root.

deserialize([], Parent) ->
    {Parent, []};
deserialize([null | Rest], _Parent) ->
    {null, Rest};
deserialize([Val | Rest], _Parent) ->
    Node = #tree_node{val = Val},
    {Left, Rest1} = deserialize(Rest, Node),
    {Right, Rest2} = deserialize(Rest1, Node),
    {Node#tree_node{left = Left, right = Right}, Rest2}.