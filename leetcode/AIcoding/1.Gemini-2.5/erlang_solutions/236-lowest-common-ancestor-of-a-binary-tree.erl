-record(tree_node, {val, left = null, right = null}).

lca(null, _, _) -> null;
lca(Node, P, Q) when Node == P; Node == Q -> Node;
lca(Node = #tree_node{left = Left, right = Right}, P, Q) ->
    LeftResult = lca(Left, P, Q),
    RightResult = lca(Right, P, Q),

    case {LeftResult, RightResult} of
        {null, null} -> null;
        {null, _} -> RightResult;
        {_, null} -> LeftResult;
        {_, _} -> Node
    end.