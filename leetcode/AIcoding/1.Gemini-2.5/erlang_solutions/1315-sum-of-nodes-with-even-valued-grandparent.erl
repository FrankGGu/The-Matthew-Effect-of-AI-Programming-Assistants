-module(solution).
-export([sumEvenGrandparent/1]).

sumEvenGrandparent(Root) ->
    % Initial parent and grandparent values are set to 1 (odd)
    % so they don't trigger the even check for the root or its direct children.
    sum(Root, 1, 1).

sum(null, _ParentVal, _GrandparentVal) ->
    0;
sum({NodeVal, Left, Right}, ParentVal, GrandparentVal) ->
    CurrentNodeSum = case GrandparentVal rem 2 of
                         0 -> NodeVal;
                         _ -> 0
                     end,
    CurrentNodeSum
    + sum(Left, NodeVal, ParentVal)
    + sum(Right, NodeVal, ParentVal).