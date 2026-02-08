-module(evaluate_boolean_binary_tree).
-export([evaluate_tree/1]).

-record(node, {val, left, right}).

evaluate_tree(#node{val=Val, left=Left, right=Right}) ->
    case Val of
        0 -> false;
        1 -> true;
        _ -> 
            LeftResult = evaluate_tree(Left),
            RightResult = evaluate_tree(Right),
            case Val of
                2 -> LeftResult or RightResult;
                3 -> LeftResult andalso RightResult
            end
    end.