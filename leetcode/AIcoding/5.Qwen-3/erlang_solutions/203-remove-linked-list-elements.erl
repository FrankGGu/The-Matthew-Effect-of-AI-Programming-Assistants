-module(remove_linked_list_elements).
-export([remove_elements/2]).

-record(list_node, {val, next}).

remove_elements(_, null) ->
    null;
remove_elements(Val, #list_node{val = Val, next = Next}) ->
    remove_elements(Val, Next);
remove_elements(Val, #list_node{val = V, next = Next}) ->
    #list_node{val = V, next = remove_elements(Val, Next)}.