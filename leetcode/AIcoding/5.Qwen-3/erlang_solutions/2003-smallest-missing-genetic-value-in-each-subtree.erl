-module(small_missing_genetic_value).
-export([findSmallestMissingGeneticValueInEachSubtree/1]).

findSmallestMissingGeneticValueInEachSubtree(Root) ->
    Tree = build_tree(Root),
    {_, Result} = dfs(Tree, 0, 0, 1, dict:new()),
    Result.

build_tree(nil) -> nil;
build_tree({Val, Left, Right}) ->
    {Val, build_tree(Left), build_tree(Right)}.

dfs(nil, _, _, _, _) -> {0, []};
dfs({Val, Left, Right}, Parent, MaxVal, MinMiss, Acc) ->
    {LeftMax, LeftResult} = dfs(Left, Val, MaxVal, MinMiss, Acc),
    {RightMax, RightResult} = dfs(Right, Val, MaxVal, MinMiss, Acc),
    CurrentMax = max(LeftMax, RightMax),
    NewMinMiss = if
        Val == 1 -> 1;
        true -> MinMiss
    end,
    NewAcc = dict:store(Val, CurrentMax, Acc),
    {CurrentMax, [NewMinMiss | LeftResult ++ RightResult]}.

build_tree_from_list([]) -> nil;
build_tree_from_list([Val, Left, Right]) ->
    {Val, build_tree_from_list(Left), build_tree_from_list(Right)}.