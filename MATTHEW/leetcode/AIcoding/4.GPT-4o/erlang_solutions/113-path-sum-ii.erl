%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec path_sum(Root :: #tree_node{} | null, TargetSum :: integer()) -> [[integer()]].
path_sum(Root, TargetSum) -> 
    path_sum(Root, TargetSum, []).

path_sum(null, _, _) -> [];
path_sum(#tree_node{val = Val, left = Left, right = Right}, TargetSum, Acc) ->
    NewAcc = lists:concat([Acc, [[Val]]]),
    case Left of
        null -> path_sum(Right, TargetSum - Val, NewAcc);
        _ -> path_sum(Left, TargetSum - Val, NewAcc)
    end.
