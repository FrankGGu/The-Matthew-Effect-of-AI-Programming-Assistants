-module(max_ancestor_diff).
-export([maxAncestorDiff/1]).

maxAncestorDiff(Root) ->
    maxAncestorDiff(Root, Root#node.val, Root#node.val).

maxAncestorDiff(Node, MaxAncestor, MinAncestor) ->
    case Node of
        null ->
            abs(MaxAncestor - MinAncestor);
        #node{val = Val, left = Left, right = Right} ->
            NewMaxAncestor = max(MaxAncestor, Val),
            NewMinAncestor = min(MinAncestor, Val),
            LeftDiff = maxAncestorDiff(Left, NewMaxAncestor, NewMinAncestor),
            RightDiff = maxAncestorDiff(Right, NewMaxAncestor, NewMinAncestor),
            max(abs(MaxAncestor - MinAncestor), max(LeftDiff, RightDiff))
    end.