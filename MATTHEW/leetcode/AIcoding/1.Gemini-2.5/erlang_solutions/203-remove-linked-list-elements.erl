-module(solution).
-export([removeElements/2]).

-record(list_node, {val :: integer(), next :: list_node() | nil}).

removeElements(nil, _Val) ->
    nil;
removeElements(#list_node{val = ValToRemove, next = Next}, ValToRemove) ->
    removeElements(Next, ValToRemove);
removeElements(#list_node{val = CurrentVal, next = Next}, ValToRemove) ->
    #list_node{val = CurrentVal, next = removeElements(Next, ValToRemove)}.