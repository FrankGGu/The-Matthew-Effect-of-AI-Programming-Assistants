%% Definition for a binary tree node.
%%
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec right_side_view(Root :: #tree_node{} | null) -> [integer()].

right_side_view(null) -> [];
right_side_view(Root) -> 
    right_side_view(Root, 1, []).

right_side_view(null, _, Acc) -> lists:reverse(Acc);
right_side_view(#tree_node{val = Val, left = Left, right = Right}, Level, Acc) ->
    right_side_view(Left, Level + 1, Acc1) ++
    right_side_view(Right, Level + 1, [Val | Acc1]).

