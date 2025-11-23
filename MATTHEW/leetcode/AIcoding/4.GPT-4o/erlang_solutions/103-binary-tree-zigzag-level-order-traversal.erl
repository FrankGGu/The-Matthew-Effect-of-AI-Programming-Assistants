%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec zigzag_level_order(Root :: #tree_node{} | null) -> [[integer()]].
zigzag_level_order(Root) ->
    zigzag_level_order([Root], true, []).

zigzag_level_order([], _, Acc) -> lists:reverse(Acc);
zigzag_level_order([null | T], Direction, Acc) -> zigzag_level_order(T, Direction, Acc);
zigzag_level_order([#tree_node{val = Val, left = Left, right = Right} | T], Direction, Acc) ->
    NextLevel = case Direction of
        true -> lists:reverse([Left, Right]);
        false -> [Right, Left]
    end,
    zigzag_level_order(T ++ NextLevel, not Direction, [[Val] | Acc]).
