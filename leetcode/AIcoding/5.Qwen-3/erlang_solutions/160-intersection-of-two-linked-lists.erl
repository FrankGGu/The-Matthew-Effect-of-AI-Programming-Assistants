-module(solution).
-export([get_intersection_node/2]).

-record(list_node, {val, next}).

get_intersection_node(A, B) ->
    get_intersection_node(A, B, 0, 0).

get_intersection_node(A, B, LA, LB) ->
    case A of
        false -> B;
        _ -> get_intersection_node(A#list_node.next, B, LA + 1, LB)
    end,
    case B of
        false -> A;
        _ -> get_intersection_node(A, B#list_node.next, LA, LB + 1)
    end,
    A1 = A,
    B1 = B,
    if
        LA > LB ->
            lists:foreach(fun(_) -> A1 = A1#list_node.next end, lists:seq(1, LA - LB)),
            get_intersection_node(A1, B1, 0, 0);
        LB > LA ->
            lists:foreach(fun(_) -> B1 = B1#list_node.next end, lists:seq(1, LB - LA)),
            get_intersection_node(A1, B1, 0, 0);
        true ->
            get_intersection_node(A1, B1, 0, 0)
    end,
    case A1 of
        false -> false;
        _ ->
            case B1 of
                false -> false;
                _ ->
                    if
                        A1 == B1 -> A1;
                        true ->
                            get_intersection_node(A1#list_node.next, B1#list_node.next, 0, 0)
                    end
            end
    end.