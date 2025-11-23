-module(solution).
-export([reverseList/1]).

-record(node, {val, next}).

reverseList(nil) ->
    nil;
reverseList(Head) ->
    reverse(Head, nil).

reverse(nil, Acc) ->
    Acc;
reverse(#node{next=Next}=Current, Acc) ->
    reverse(Next, #node{val=Current#node.val, next=Acc}).