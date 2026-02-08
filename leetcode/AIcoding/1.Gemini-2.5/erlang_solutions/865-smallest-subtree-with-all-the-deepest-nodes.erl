-module(solution).
-export([subtreeWithAllDeepest/1]).

-record(tree_node, {val, left, right}).

subtreeWithAllDeepest(Root) ->
    {_Depth, Node} = dfs(Root),
    Node.

dfs(nil) ->
    {0, nil};
dfs(#tree_node{val=_Val, left=Left, right=Right} = Node) ->
    {LeftDepth, LeftAns} = dfs(Left),
    {RightDepth, RightAns} = dfs(Right),

    if
        LeftDepth == RightDepth ->
            {LeftDepth + 1, Node};
        LeftDepth > RightDepth ->
            {LeftDepth + 1, LeftAns};
        true -> %% RightDepth > LeftDepth
            {RightDepth + 1, RightAns}
    end.