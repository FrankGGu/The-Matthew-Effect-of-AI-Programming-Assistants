-spec is_balanced(Root :: #tree_node{} | null) -> boolean().
is_balanced(null) -> true;
is_balanced(Root) ->
    {Balanced, _} = check_balanced(Root),
    Balanced.

check_balanced(null) -> {true, 0};
check_balanced(#tree_node{left = Left, right = Right}) ->
    {LeftBalanced, LeftHeight} = check_balanced(Left),
    {RightBalanced, RightHeight} = check_balanced(Right),
    HeightDiff = abs(LeftHeight - RightHeight),
    Balanced = LeftBalanced andalso RightBalanced andalso HeightDiff =< 1,
    Height = max(LeftHeight, RightHeight) + 1,
    {Balanced, Height}.