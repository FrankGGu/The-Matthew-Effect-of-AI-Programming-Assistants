-module(solution).
-export([connect_trees/2]).

connect_trees(Root1, Root2) ->
    Count1 = count_nodes(Root1),
    Count2 = count_nodes(Root2),
    if
        Count1 > Count2 -> Count1;
        true -> Count2
    end.

count_nodes(nil) -> 0;
count_nodes({Node, Left, Right}) ->
    1 + count_nodes(Left) + count_nodes(Right).