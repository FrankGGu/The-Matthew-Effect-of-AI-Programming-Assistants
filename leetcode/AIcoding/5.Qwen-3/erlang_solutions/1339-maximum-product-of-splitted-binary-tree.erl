-module(solution).
-export([max_product/1]).

-record(tree, {val, left, right}).

max_product(Root) ->
    Total = sum_tree(Root),
    {Max, _} = dfs(Root, Total),
    Max.

sum_tree(nil) -> 0;
sum_tree(#tree{val = Val, left = Left, right = Right}) ->
    Val + sum_tree(Left) + sum_tree(Right).

dfs(nil, _) -> {0, 0};
dfs(#tree{val = Val, left = Left, right = Right}, Total) ->
    {LeftMax, LeftSum} = dfs(Left, Total),
    {RightMax, RightSum} = dfs(Right, Total),
    CurrentSum = Val + LeftSum + RightSum,
    CurrentProduct = (Total - CurrentSum) * CurrentSum,
    Max = max(LeftMax, RightMax),
    Max2 = max(Max, CurrentProduct),
    {Max2, CurrentSum}.