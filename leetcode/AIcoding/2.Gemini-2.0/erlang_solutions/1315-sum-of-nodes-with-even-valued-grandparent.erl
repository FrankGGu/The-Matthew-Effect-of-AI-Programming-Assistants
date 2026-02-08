-module(sum_even_grandparent).
-export([sum_even_grandparent/1]).

sum_even_grandparent(Root) ->
    helper(Root, 1, 1).

helper(null, _, _) ->
    0;
helper({Val, Left, Right}, Parent, GrandParent) ->
    Sum = case GrandParent rem 2 of
        0 -> Val;
        _ -> 0
    end,
    NewParent = Val,
    NewGrandParent = Parent,
    Sum + helper(Left, NewParent, NewGrandParent) + helper(Right, NewParent, NewGrandParent).