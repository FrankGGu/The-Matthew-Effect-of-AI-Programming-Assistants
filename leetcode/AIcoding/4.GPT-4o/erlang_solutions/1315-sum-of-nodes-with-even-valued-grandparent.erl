-module(solution).
-export([sum_even_grandparent/1]).

-record(node, {val, left = nil, right = nil}).

sum_even_grandparent(Root) ->
    sum_even_grandparent_helper(Root, nil, nil).

sum_even_grandparent_helper(nil, _, _) -> 
    0;
sum_even_grandparent_helper(#node{val = Val, left = Left, right = Right}, Parent, Grandparent) ->
    Grandchild_sum = case Grandparent rem 2 of
        0 -> Val;
        _ -> 0
    end + sum_even_grandparent_helper(Left, Val, Parent) +
           sum_even_grandparent_helper(Right, Val, Parent).