-module(solution).
-export([lowestCommonAncestor/1]).

-record(node, {val, left = null, right = null}).

lowestCommonAncestor(Root) ->
    {LCA, _} = lca_deepest_leaves(Root),
    LCA.

lca_deepest_leaves(null) -> {null, 0};
lca_deepest_leaves(#node{left=Left, right=Right, val=Val}) ->
    {LeftLCA, LeftDepth} = lca_deepest_leaves(Left),
    {RightLCA, RightDepth} = lca_deepest_leaves(Right),
    case LeftDepth of
        0 -> {RightLCA, RightDepth + 1};
        _ -> case RightDepth of
            0 -> {LeftLCA, LeftDepth + 1};
            _ -> if
                LeftDepth > RightDepth -> {LeftLCA, LeftDepth + 1};
                LeftDepth < RightDepth -> {RightLCA, RightDepth + 1};
                true -> {#node{val=Val, left=LeftLCA, right=RightLCA}, LeftDepth + 1}
            end
        end
    end.