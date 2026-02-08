-module(delete_nodes).
-export([delete_nodes/2]).

delete_nodes(Head, Val) ->
    delete_nodes_helper(Head, Val, null).

delete_nodes_helper(null, _, _) ->
    null;
delete_nodes_helper(Head, Val, Prev) ->
    case lists:member(Head#node.val, Val) of
        true ->
            case Prev of
                null ->
                    delete_nodes_helper(Head#node.next, Val, null);
                _ ->
                    Prev#node.next = Head#node.next,
                    delete_nodes_helper(Head#node.next, Val, Prev)
            end;
        false ->
            Head#node{next = delete_nodes_helper(Head#node.next, Val, Head)}
    end.

-record(node, {val, next}).