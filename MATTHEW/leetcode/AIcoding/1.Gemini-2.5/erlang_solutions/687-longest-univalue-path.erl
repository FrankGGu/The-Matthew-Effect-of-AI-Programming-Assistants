-module(solution).

-record(tree_node, {val, left, right}).

-spec longest_univalue_path(Root :: #tree_node{} | nil) -> integer().
longest_univalue_path(Root) ->
    {MaxPath, _} = dfs(Root),
    MaxPath.

dfs(nil) ->
    {0, 0};
dfs(#tree_node{val=Val, left=Left, right=Right}) ->
    {LeftMaxPath, LeftLongestFromChild} = dfs(Left),
    {RightMaxPath, RightLongestFromChild} = dfs(Right),

    LeftPath =
        case Left of
            nil -> 0;
            #tree_node{val=LeftVal} when LeftVal == Val -> LeftLongestFromChild + 1;
            _ -> 0
        end,

    RightPath =
        case Right of
            nil -> 0;
            #tree_node{val=RightVal} when RightVal == Val -> RightLongestFromChild + 1;
            _ -> 0
        end,

    LongestPathFromThisNode = max(LeftPath, RightPath),

    OverallMaxPath = max(LeftMaxPath, RightMaxPath, LeftPath + RightPath),

    {OverallMaxPath, LongestPathFromThisNode}.