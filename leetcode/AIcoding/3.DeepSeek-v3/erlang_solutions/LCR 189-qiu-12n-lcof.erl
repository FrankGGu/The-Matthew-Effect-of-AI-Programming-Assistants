-module(accumulator).
-export([new/0, add/2, get/1]).

new() ->
    dict:new().

add(Acc, Val) ->
    dict:store(Val, true, Acc).

get(Acc) ->
    dict:fold(fun(Key, _, Sum) -> Sum + Key end, 0, Acc).