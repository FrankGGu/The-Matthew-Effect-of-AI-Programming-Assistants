-module(solution).
-export([reverse_list/1]).

reverse_list(Head) ->
    reverse_list(Head, null).

reverse_list(null, Acc) ->
    Acc;
reverse_list(#node{val = Val, next = Next}, Acc) ->
    reverse_list(Next, #node{val = Val, next = Acc}).