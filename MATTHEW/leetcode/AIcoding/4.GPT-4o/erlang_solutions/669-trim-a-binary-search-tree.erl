-module(solution).
-export([trim_bst/3]).

-record(tree, {val, left = null, right = null}).

trim_bst(Root, Low, High) ->
    case Root of
        null -> null;
        #tree{val = Val, left = Left, right = Right} ->
            case Val of
                _ when Val < Low -> trim_bst(Right, Low, High);
                _ when Val > High -> trim_bst(Left, Low, High);
                _ -> #tree{val = Val, 
                           left = trim_bst(Left, Low, High), 
                           right = trim_bst(Right, Low, High)}
            end
    end.