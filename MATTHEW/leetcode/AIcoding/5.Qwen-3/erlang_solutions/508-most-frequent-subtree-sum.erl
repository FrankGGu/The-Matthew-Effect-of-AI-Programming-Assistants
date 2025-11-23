-module(most_frequent_subtree_sum).
-export([tree_sum/1]).

tree_sum(undefined) -> [];
tree_sum({Val, Left, Right}) ->
    {Sum, Sums} = dfs(Val, Left, Right),
    Count = maps:from_list([{S, 0} || S <- Sums]),
    Count2 = lists:foldl(fun(S, Acc) -> maps:update(S, Acc#{S => Acc#{S} + 1}, Acc) end, Count, Sums),
    MaxFreq = lists:max([V || {_, V} <- maps:to_list(Count2)]),
    [K || {K, V} <- maps:to_list(Count2), V == MaxFreq].

dfs(Val, undefined, undefined) ->
    {Val, [Val]};
dfs(Val, Left, undefined) ->
    {LVal, LList} = dfs(Left),
    Sum = Val + LVal,
    {Sum, [Sum | LList]};
dfs(Val, undefined, Right) ->
    {RVal, RList} = dfs(Right),
    Sum = Val + RVal,
    {Sum, [Sum | RList]};
dfs(Val, Left, Right) ->
    {LVal, LList} = dfs(Left),
    {RVal, RList} = dfs(Right),
    Sum = Val + LVal + RVal,
    {Sum, [Sum | LList ++ RList]}.