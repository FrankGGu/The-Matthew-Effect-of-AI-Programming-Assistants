-module(delete_node).
-export([delete_node/2]).

-spec delete_node(ListNode :: list(), Node :: list()) -> list().
delete_node(Head, Node) ->
    delete_node(Head, Node, []).

delete_node([], _, Acc) ->
    lists:reverse(Acc);
delete_node([H|T], Node, Acc) ->
    if
        H == Node ->
            lists:reverse(Acc) ++ T;
        true ->
            delete_node(T, Node, Acc ++ [H])
    end.