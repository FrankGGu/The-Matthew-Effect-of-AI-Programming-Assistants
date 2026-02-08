-module(solution).
-export([findBottomLeftValue/1]).

-record(tree_node, {val, left, right}).

findBottomLeftValue(Root) ->
    {_MaxDepth, ResultValue} = dfs(Root, 0, -1, undefined),
    ResultValue.

dfs(nil, _CurrentDepth, AccMaxDepth, AccResultValue) ->
    {AccMaxDepth, AccResultValue};
dfs(#tree_node{val=Val, left=Left, right=Right}, CurrentDepth, AccMaxDepth, AccResultValue) ->
    {UpdatedMaxDepth, UpdatedResultValue} =
        if CurrentDepth > AccMaxDepth ->
            {CurrentDepth, Val};
        true ->
            {AccMaxDepth, AccResultValue}
        end,

    {LeftMaxDepth, LeftResultValue} = dfs(Left, CurrentDepth + 1, UpdatedMaxDepth, UpdatedResultValue),

    dfs(Right, CurrentDepth + 1, LeftMaxDepth, LeftResultValue).