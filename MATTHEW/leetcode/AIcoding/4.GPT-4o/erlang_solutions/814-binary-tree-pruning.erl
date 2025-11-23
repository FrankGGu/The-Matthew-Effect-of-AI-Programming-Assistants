-record(node, {val, left = null, right = null}).

pruneTree(Root) ->
    case prune(Root) of
        null -> null;
        Pruned -> Pruned
    end.

prune(null) -> null;
prune(#node{val=0, left=Left, right=Right}) ->
    case {prune(Left), prune(Right)} of
        {null, null} -> null;
        {PrunedLeft, null} -> PrunedLeft;
        {null, PrunedRight} -> PrunedRight;
        {PrunedLeft, PrunedRight} -> #node{val=0, left=PrunedLeft, right=PrunedRight}
    end;
prune(#node{val=Val, left=Left, right=Right}) ->
    #node{val=Val, left=prune(Left), right=prune(Right)}.