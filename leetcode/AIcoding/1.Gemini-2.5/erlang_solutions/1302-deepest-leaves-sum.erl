-module(solution).

-export([deepest_leaves_sum/1]).

-record(treenode, {val, left, right}).

-spec deepest_leaves_sum(Root :: treenode() | nil) -> integer().
deepest_leaves_sum(Root) ->
    {_MaxDepth, Sum} = dfs(Root, 0),
    Sum.

dfs(nil, _CurrentDepth) ->
    {-1, 0}.

dfs(#treenode{val = Val, left = Left, right = Right}, CurrentDepth) ->
    {LeftMaxDepth, LeftSum} = dfs(Left, CurrentDepth + 1),
    {RightMaxDepth, RightSum} = dfs(Right, CurrentDepth + 1),

    if LeftMaxDepth == -1 andalso RightMaxDepth == -1 ->
        {CurrentDepth, Val};
    LeftMaxDepth > RightMaxDepth ->
        {LeftMaxDepth, LeftSum};
    RightMaxDepth > LeftMaxDepth ->
        {RightMaxDepth, RightSum};
    LeftMaxDepth == RightMaxDepth ->
        {LeftMaxDepth, LeftSum + RightSum}
    end.