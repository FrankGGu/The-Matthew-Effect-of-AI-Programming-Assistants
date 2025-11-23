-module(solution).
-export([reverseList/1]).

-record(list_node, {val = 0, next = null}).

reverseList(Head) ->
    reverse_iter(Head, null).

reverse_iter(null, Prev) ->
    Prev;
reverse_iter(Current, Prev) ->
    NextTemp = Current#list_node.next,
    NewCurrent = Current#list_node{next = Prev},
    reverse_iter(NextTemp, NewCurrent).