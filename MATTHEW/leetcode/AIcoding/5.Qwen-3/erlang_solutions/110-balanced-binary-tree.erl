-module(balanced_binary_tree).
-export([is_balanced/1]).

-record(tree, {val, left, right}).

is_balanced(null) -> true;
is_balanced({tree, Val, Left, Right}) ->
    Height = get_height({tree, Val, Left, Right}),
    case Height of
        -1 -> false;
        _ -> true
    end.

get_height(null) -> 0;
get_height({tree, Val, Left, Right}) ->
    LeftHeight = get_height(Left),
    RightHeight = get_height(Right),
    if
        LeftHeight == -1; RightHeight == -1 -> -1;
        abs(LeftHeight - RightHeight) > 1 -> -1;
        true -> 1 + max(LeftHeight, RightHeight)
    end.