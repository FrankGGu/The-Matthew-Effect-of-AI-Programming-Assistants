-module(solution).
-export([is_balanced/1]).

is_balanced(Root) ->
    case check_height(Root) of
        -1 -> false;
        _ -> true
    end.

check_height(nil) ->
    0;
check_height({_, Left, Right}) ->
    LeftHeight = check_height(Left),
    case LeftHeight of
        -1 -> -1;
        _ ->
            RightHeight = check_height(Right),
            case RightHeight of
                -1 -> -1;
                _ ->
                    Diff = abs(LeftHeight - RightHeight),
                    if Diff > 1 -> -1;
                       true -> 1 + max(LeftHeight, RightHeight)
                    end
            end
    end.