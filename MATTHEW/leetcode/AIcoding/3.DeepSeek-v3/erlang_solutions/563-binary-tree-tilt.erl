-spec find_tilt(Root :: #tree_node{} | null) -> integer().
find_tilt(Root) ->
    {Sum, Tilt} = traverse(Root),
    Tilt.

traverse(null) ->
    {0, 0};
traverse(#tree_node{val = Val, left = Left, right = Right}) ->
    {LeftSum, LeftTilt} = traverse(Left),
    {RightSum, RightTilt} = traverse(Right),
    Sum = Val + LeftSum + RightSum,
    Tilt = LeftTilt + RightTilt + abs(LeftSum - RightSum),
    {Sum, Tilt}.