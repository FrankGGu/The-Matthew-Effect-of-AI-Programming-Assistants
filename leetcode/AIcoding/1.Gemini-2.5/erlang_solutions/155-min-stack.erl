-module(min_stack).
-export([new/0, push/2, pop/1, top/1, get_min/1]).

new() ->
    [].

push(X, []) ->
    [{X, X}].
push(X, [{_, CurrentMin} | _] = Stack) ->
    [{X, min(X, CurrentMin)} | Stack].

pop([_ | Rest]) ->
    Rest.

top([{Value, _} | _]) ->
    Value.

get_min([{_, MinAtThisPoint} | _]) ->
    MinAtThisPoint.