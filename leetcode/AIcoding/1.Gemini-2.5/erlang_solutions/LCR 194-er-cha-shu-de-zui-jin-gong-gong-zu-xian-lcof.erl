-module(solution).
-export([lowestCommonAncestor/3]).

-record(tree_node, {val, left = nil, right = nil}).

lowestCommonAncestor(nil, _, _) ->
    nil;
lowestCommonAncestor(Root, P, Q) ->
    case Root of
        P -> P;
        Q -> Q;
        _ ->
            LeftLCA = lowestCommonAncestor(Root#tree_node.left, P, Q),
            RightLCA = lowestCommonAncestor(Root#tree_node.right, P, Q),
            case {LeftLCA, RightLCA} of
                {nil, nil} -> nil;
                {nil, _} -> RightLCA;
                {_, nil} -> LeftLCA;
                {_, _} -> Root
            end
    end.