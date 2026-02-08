-module(solution).
-export([root_equals_subtree_sum/1]).

root_equals_subtree_sum(#{
    value := Value,
    left := Left,
    right := Right
}) ->
    LeftVal = case Left of
        null -> 0;
        _ -> root_equals_subtree_sum(Left)
    end,
    RightVal = case Right of
        null -> 0;
        _ -> root_equals_subtree_sum(Right)
    end,
    Value == LeftVal + RightVal.