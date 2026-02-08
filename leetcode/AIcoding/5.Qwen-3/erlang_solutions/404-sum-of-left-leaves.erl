-module(solve).
-export([sum_of_left_leaves/1]).

sum_of_left_leaves(undefined) -> 0;
sum_of_left_leaves({Val, Left, Right}) ->
    sum_of_left_leaves(Left, Val, Right, 0).

sum_of_left_leaves(undefined, _, _, Acc) -> Acc;
sum_of_left_leaves({Val, Left, Right}, ParentVal, ParentRight, Acc) ->
    case Left of
        undefined ->
            sum_of_left_leaves(Right, Val, ParentRight, Acc);
        _ ->
            sum_of_left_leaves(Right, Val, ParentRight, Acc + sum_of_left_leaves(Left, Val, ParentRight, 0))
    end.