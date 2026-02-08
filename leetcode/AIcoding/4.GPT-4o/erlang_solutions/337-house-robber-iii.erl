%% Definition for a binary tree node.
%%
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec rob(Root :: #tree_node{} | null) -> integer().
rob(Root) ->
    rob_helper(Root).

-spec rob_helper(Root :: #tree_node{} | null) -> {integer(), integer()}.
rob_helper(null) -> {0, 0};
rob_helper(#tree_node{val = Val, left = Left, right = Right}) ->
    {left_with, left_without} = rob_helper(Left),
    {right_with, right_without} = rob_helper(Right),
    With = Val + left_without + right_without,
    Without = max(left_with, left_without) + max(right_with, right_without),
    {With, Without}.

-spec max(A :: integer(), B :: integer()) -> integer().
max(A, B) when A >= B -> A;
max(_, B) -> B.
