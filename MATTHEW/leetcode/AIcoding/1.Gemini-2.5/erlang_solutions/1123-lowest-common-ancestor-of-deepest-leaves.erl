-module(solution).
-export([lcaDeepestLeaves/1]).

lcaDeepestLeaves(Root) ->
    {_Depth, LCA} = dfs(Root),
    LCA.

dfs(nil) ->
    {0, nil};
dfs({Val, Left, Right}) ->
    {LeftDepth, LeftLCA} = dfs(Left),
    {RightDepth, RightLCA} = dfs(Right),

    if
        LeftDepth == RightDepth ->
            {LeftDepth + 1, {Val, Left, Right}};
        LeftDepth > RightDepth ->
            {LeftDepth + 1, LeftLCA};
        true ->
            {RightDepth + 1, RightLCA}
    end.