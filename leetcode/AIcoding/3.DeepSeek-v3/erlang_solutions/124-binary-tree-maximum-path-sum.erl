-spec max_path_sum(Root :: #tree_node{} | null) -> integer().
max_path_sum(Root) ->
    {Max, _} = helper(Root),
    Max.

helper(null) ->
    { -1000000000, 0 };
helper(#tree_node{val = Val, left = Left, right = Right}) ->
    {LeftMax, LeftSum} = helper(Left),
    {RightMax, RightSum} = helper(Right),

    CurrentMax = lists:max([
        Val,
        Val + LeftSum,
        Val + RightSum
    ]),

    TotalMax = lists:max([
        LeftMax,
        RightMax,
        CurrentMax,
        Val + LeftSum + RightSum
    ]),

    {TotalMax, CurrentMax}.