-module(solution).
-export([maxScore/1]).

maxScore(Root) ->
    Tree = build_tree(Root),
    {_, Max} = dfs(Tree, 0),
    Max.

build_tree([]) -> [];
build_tree([Val, Left, Right]) ->
    {Val, build_tree(Left), build_tree(Right)}.

dfs({Val, Left, Right}, Parent) ->
    case {Left, Right} of
        {[], []} ->
            {Val, 0};
        _ ->
            {LeftSum, LeftMax} = dfs(Left, Val),
            {RightSum, RightMax} = dfs(Right, Val),
            Current = Val + LeftSum + RightSum,
            Max = max(LeftMax, RightMax),
            {Current, Max}
    end.