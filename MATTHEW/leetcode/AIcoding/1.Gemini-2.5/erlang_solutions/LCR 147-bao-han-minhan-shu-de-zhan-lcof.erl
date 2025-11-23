-module(min_stack).
-export([new/0, push/2, pop/1, top/1, getMin/1]).

new() ->
    [].

push([], Val) ->
    [{Val, Val}].
push([{_PrevVal, CurrentMin} | _RestStack] = Stack, Val) ->
    NewMin = min(Val, CurrentMin),
    [{Val, NewMin} | Stack].

pop([_Head | Tail]) ->
    Tail.

top([{Val, _Min} | _Tail]) ->
    Val.

getMin([{_Val, Min} | _Tail]) ->
    Min.