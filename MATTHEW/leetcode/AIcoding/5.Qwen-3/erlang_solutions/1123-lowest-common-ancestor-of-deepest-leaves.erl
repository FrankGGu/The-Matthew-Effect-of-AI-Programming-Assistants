-module(lca_of_deepest_leaves).
-export([lca/1]).

-record(TreeNode, {val, left, right}).

lca(Null) when Null =:= null -> null;
lca(Root) ->
    {Node, _} = dfs(Root),
    Node.

dfs(null) -> {null, 0};
dfs(Node) ->
    {LeftNode, LeftDepth} = dfs(Node#TreeNode.left),
    {RightNode, RightDepth} = dfs(Node#TreeNode.right),
    if
        LeftDepth > RightDepth ->
            {LeftNode, LeftDepth + 1};
        RightDepth > LeftDepth ->
            {RightNode, RightDepth + 1};
        true ->
            {Node, LeftDepth + 1}
    end.