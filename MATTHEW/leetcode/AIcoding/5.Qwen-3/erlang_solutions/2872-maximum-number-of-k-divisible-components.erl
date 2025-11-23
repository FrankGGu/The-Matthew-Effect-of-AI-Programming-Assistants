-module(maximum_number_of_k_divisible_components).
-export([num_components/2]).

num_components(Root, K) ->
    {Count, _} = dfs(Root, K),
    Count.

dfs(nil, _) ->
    {0, 0};
dfs({Value, Left, Right}, K) ->
    {LeftCount, LeftSum} = dfs(Left, K),
    {RightCount, RightSum} = dfs(Right, K),
    TotalSum = Value + LeftSum + RightSum,
    if
        TotalSum rem K == 0 ->
            {LeftCount + RightCount + 1, TotalSum};
        true ->
            {LeftCount + RightCount, TotalSum}
    end.