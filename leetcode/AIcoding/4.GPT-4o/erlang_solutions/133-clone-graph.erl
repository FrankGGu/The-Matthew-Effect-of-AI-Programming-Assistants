%% Definition for a Node.
%% -record(node, {val = 0 :: integer(), neighbors = [] :: [#node{}}]).

-spec clone_graph(Node :: #node{} | null) -> #node{} | null.
clone_graph(null) -> null;
clone_graph(#node{val = Val, neighbors = Neighbors}) ->
    clone_graph(Val, Neighbors, #{}).

clone_graph(_, [], ClonedNodes) -> [];
clone_graph(Val, [Neighbor | Rest], ClonedNodes) ->
    case maps:get(Val, ClonedNodes, undefined) of
        undefined ->
            ClonedNode = #node{val = Val, neighbors = clone_graph(Neighbor, Rest, ClonedNodes)};
            [ClonedNode | clone_graph(Val, Rest, maps:put(Val, ClonedNode, ClonedNodes))];
        _ -> clone_graph(Val, Rest, ClonedNodes)
    end.
