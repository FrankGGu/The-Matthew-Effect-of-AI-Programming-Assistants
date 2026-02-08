-module(solve).
-export([subtreeWithAllDeepest/1]).

-record(tree, {val, left, right}).

subtreeWithAllDeepest(undefined) -> undefined;
subtreeWithAllDeepest(Tree) ->
    {Node, _} = dfs(Tree),
    Node.

dfs(undefined) -> {undefined, 0};
dfs(Node) ->
    {LeftNode, LeftDepth} = dfs(Node#tree.left),
    {RightNode, RightDepth} = dfs(Node#tree.right),
    if
        LeftDepth > RightDepth ->
            {Node, LeftDepth + 1};
        RightDepth > LeftDepth ->
            {Node, RightDepth + 1};
        true ->
            {Node, LeftDepth + 1}
    end.