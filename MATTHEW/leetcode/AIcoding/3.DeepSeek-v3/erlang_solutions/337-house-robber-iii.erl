-spec rob(Root :: #tree_node{} | null) -> integer().
rob(Root) ->
    {A, B} = rob_helper(Root),
    max(A, B).

rob_helper(null) ->
    {0, 0};
rob_helper(#tree_node{val = Val, left = Left, right = Right}) ->
    {LeftNotRob, LeftRob} = rob_helper(Left),
    {RightNotRob, RightRob} = rob_helper(Right),
    RobCurrent = Val + LeftNotRob + RightNotRob,
    NotRobCurrent = max(LeftRob, LeftNotRob) + max(RightRob, RightNotRob),
    {NotRobCurrent, RobCurrent}.