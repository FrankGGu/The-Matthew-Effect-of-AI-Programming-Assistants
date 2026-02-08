-module(intersection_of_two_linked_lists).
-export([get_intersection_node/1]).

-record(list_node, {val, next}).

get_intersection_node(#list_node{next = NextA} = A) ->
    get_intersection_node(A, NextA, A, 0).

get_intersection_node(A, A, B, _) ->
    B;
get_intersection_node(A, NextA, B, Count) ->
    case NextA of
        undefined ->
            undefined;
        _ ->
            get_intersection_node(A, NextA#list_node.next, B, Count + 1)
    end.

get_intersection_node(A, _, B, Count) ->
    get_intersection_node(A, B, B, Count).

get_intersection_node(_, _, _, 0) ->
    undefined;
get_intersection_node(A, B, B, Count) ->
    get_intersection_node(A, B#list_node.next, B, Count - 1);
get_intersection_node(A, B, NextB, Count) ->
    get_intersection_node(A, B, NextB#list_node.next, Count - 1).