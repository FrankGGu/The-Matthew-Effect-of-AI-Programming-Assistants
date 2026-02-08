-module(reorder_list).
-export([reorder_list/1]).

-record(list_node, {val, next}).

reorder_list(Head) ->
    case Head of
        false -> false;
        _ -> reorder(Head)
    end.

reorder(Head) ->
    Nodes = collect_nodes(Head, []),
    Len = length(Nodes),
    reorder_list(Nodes, 0, Len - 1, []).

collect_nodes(false, Acc) ->
    lists:reverse(Acc);
collect_nodes(#list_node{val = Val, next = Next}, Acc) ->
    collect_nodes(Next, [#list_node{val = Val} | Acc]).

reorder_list([], _, _, Acc) ->
    lists:reverse(Acc);
reorder_list([H | T], I, J, Acc) ->
    if
        I == J -> reorder_list(T, I + 1, J - 1, [H | Acc]);
        true -> reorder_list(T, I + 1, J - 1, [H, lists:nth(J + 1, Nodes) | Acc])
    end.