-module(two_sum_bst).
-export([find_target/2]).

find_target(Root, K) ->
    Values = in_order_traversal(Root, []),
    find_sum(Values, K).

in_order_traversal(null, Acc) ->
    Acc;
in_order_traversal({Node, Left, Right}, Acc) ->
    in_order_traversal(Left,
                       [Node | in_order_traversal(Right, Acc)]).

find_sum([H|T], K) ->
    case find(T, K - H) of
        true -> true;
        false -> find_sum(T, K)
    end;
find_sum([], _) ->
    false.

find([H|_], Target) when H =:= Target ->
    true;
find([_|T], Target) ->
    find(T, Target);
find([], _) ->
    false.