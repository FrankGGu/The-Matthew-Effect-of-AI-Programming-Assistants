-module(swap_nodes).
-export([swap_pairs/1]).

-record(list_node, {val, next}).

swap_pairs(Head) ->
    swap_pairs(Head, undefined).

swap_pairs(undefined, _Prev) ->
    undefined;
swap_pairs(#list_node{val = Val, next = Next}, Prev) ->
    case Next of
        undefined ->
            #list_node{val = Val, next = Prev};
        _ ->
            NewNext = swap_pairs(Next#list_node.next, Next),
            #list_node{val = Next#list_node.val, next = #list_node{val = Val, next = NewNext}}
    end.