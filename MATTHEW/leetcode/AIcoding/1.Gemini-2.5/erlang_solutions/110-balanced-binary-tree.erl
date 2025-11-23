-module(solution).
-export([is_balanced/1]).

-record(treenode, {val, left = nil, right = nil}).

is_balanced(Root) ->
    check_height_and_balance(Root) /= -1.

check_height_and_balance(nil) ->
    0;
check_height_and_balance(#treenode{left = Left, right = Right}) ->
    LeftHeight = check_height_and_balance(Left),
    RightHeight = check_height_and_balance(Right),

    if
        LeftHeight == -1; RightHeight == -1 ->
            -1;
        abs(LeftHeight - RightHeight) > 1 ->
            -1;
        true ->
            1 + max(LeftHeight, RightHeight)
    end.