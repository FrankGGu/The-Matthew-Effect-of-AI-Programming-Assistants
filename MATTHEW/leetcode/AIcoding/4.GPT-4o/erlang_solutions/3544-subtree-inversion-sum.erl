-module(subtree_inversion_sum).
-export([invert_subtree_sum/2]).

-record(tree, {value, left = none, right = none}).

invert_subtree_sum(Tree, X) ->
    case invert_sum(Tree, X) of
        {ok, Sum} -> Sum;
        error -> 0
    end.

invert_sum(none, _) -> {ok, 0};
invert_sum(#tree{value = Value, left = Left, right = Right}, X) ->
    case Value == X of
        true -> 
            {ok, Value + sum_tree(Left) + sum_tree(Right)};
        false -> 
            case invert_sum(Left, X) of
                {ok, LeftSum} -> 
                    case invert_sum(Right, X) of
                        {ok, RightSum} -> 
                            {ok, LeftSum + RightSum};
                        error -> error
                    end;
                error -> error
            end
    end.

sum_tree(none) -> 0;
sum_tree(#tree{value = Value, left = Left, right = Right}) ->
    Value + sum_tree(Left) + sum_tree(Right).