-module(solution).
-export([find_bottom_left_value/1]).

-record(tree_node, {val, left, right}).

find_bottom_left_value(Root) ->
    find_bottom_left_value(Root, 0, 0, Root).

find_bottom_left_value(null, _, _, Acc) ->
    Acc#tree_node.val;
find_bottom_left_value(#tree_node{val=Val, left=Left, right=Right}, Level, MaxLevel, Acc) ->
    case Level > MaxLevel of
        true ->
            find_bottom_left_value(Left, Level + 1, Level, #tree_node{val=Val, left=Left, right=Right}),
            find_bottom_left_value(Right, Level + 1, Level, #tree_node{val=Val, left=Left, right=Right});
        false ->
            find_bottom_left_value(Left, Level + 1, MaxLevel, Acc),
            find_bottom_left_value(Right, Level + 1, MaxLevel, Acc)
    end.