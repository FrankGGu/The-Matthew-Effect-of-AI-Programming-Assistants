-module(solution).
-export([countHighestScore/1]).

countHighestScore(Params) ->
    [Root] = Params,
    Tree = build_tree(Root),
    {MaxScore, Count} = dfs(Tree, 0),
    Count.

build_tree([]) -> nil;
build_tree([Left, Right | _]) ->
    {node, build_tree(Left), build_tree(Right)}.

dfs(nil, _) -> {0, 0};
dfs({node, Left, Right}, ParentCount) ->
    LeftCount = count_nodes(Left),
    RightCount = count_nodes(Right),
    Total = LeftCount + RightCount + 1,
    Score = case ParentCount of
        0 -> LeftCount * RightCount;
        _ -> (Total - 1) * LeftCount * RightCount
    end,
    {LeftScore, LeftCount} = dfs(Left, Total),
    {RightScore, RightCount} = dfs(Right, Total),
    MaxScore = max(Score, max(LeftScore, RightScore)),
    Count = if
        Score == MaxScore -> 1;
        true -> 0
    end,
    Count1 = if
        LeftScore == MaxScore -> Count + LeftCount;
        true -> Count
    end,
    Count2 = if
        RightScore == MaxScore -> Count1 + RightCount;
        true -> Count1
    end,
    {MaxScore, Count2}.

count_nodes(nil) -> 0;
count_nodes({node, Left, Right}) ->
    1 + count_nodes(Left) + count_nodes(Right).