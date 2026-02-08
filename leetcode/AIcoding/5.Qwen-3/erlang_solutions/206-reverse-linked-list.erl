-module(reverse_linked_list).
-export([reverse_list/1]).

-record(list_node, {val, next}).

reverse_list(Head) ->
    reverse_list(Head, none).

reverse_list(none, _Acc) ->
    none;
reverse_list(#list_node{val=Val, next=Next}, Acc) ->
    reverse_list(Next, #list_node{val=Val, next=Acc}).