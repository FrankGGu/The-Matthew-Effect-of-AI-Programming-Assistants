%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec level_order(Root :: #tree_node{} | null) -> [[integer()]].
level_order(null) -> [];
level_order(Root) ->
    level_order([Root], []).

level_order([], Acc) -> lists:reverse(Acc);
level_order(Queue, Acc) ->
    {Vals, NextLevel} = lists:foldl(fun(Node, {Vals, NextLevel}) ->
                                         case Node of
                                             #tree_node{val = Val, left = L, right = R} ->
                                                 {Vals ++ [Val], NextLevel ++ [L, R]}
                                         end
                                     end, {[], []}, Queue),
    level_order(NextLevel, [Vals | Acc]).
