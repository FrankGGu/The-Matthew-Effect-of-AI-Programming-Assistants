-record(node, {
    val = 0 :: integer(),
    neighbors = [] :: [#node{}]
}).

-spec clone_graph(Node :: #node{} | null) -> #node{} | null.
clone_graph(null) -> null;
clone_graph(Node) ->
    Map = maps:new(),
    clone(Node, Map).

-spec clone(Node :: #node{}, Map :: map()) -> #node{}.
clone(Node, Map) ->
    case maps:is_key(Node#node.val, Map) of
        true -> maps:get(Node#node.val, Map);
        false ->
            NewNode = #node{val = Node#node.val},
            Map1 = maps:put(NewNode#node.val, NewNode, Map),
            NewNeighbors = lists:map(fun(N) -> clone(N, Map1) end, Node#node.neighbors),
            NewNode#node{neighbors = NewNeighbors}
    end.