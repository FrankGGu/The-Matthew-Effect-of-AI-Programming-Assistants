%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec is_balanced(Root :: #tree_node{} | null) -> boolean().
is_balanced(null) -> true;
is_balanced(#tree_node{left = Left, right = Right}) ->
    is_balanced(Left) andalso is_balanced(Right) andalso abs(depth(Left) - depth(Right)) =< 1.

depth(null) -> 0;
depth(#tree_node{left = Left, right = Right}) ->
    1 + max(depth(Left), depth(Right)).

max(A, B) when A >= B -> A;
max(A, B) -> B.
