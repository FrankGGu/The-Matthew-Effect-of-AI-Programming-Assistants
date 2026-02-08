-module(hash_map).
-export([new/0, put/3, get/2, remove/2]).

new() ->
    [].

put(Key, Value, Map) ->
    case lists:keyfind(Key, 1, Map) of
        {Key, _} ->
            lists:keyreplace(Key, 1, Map, {Key, Value});
        false ->
            [{Key, Value} | Map]
    end.

get(Key, Map) ->
    case lists:keyfind(Key, 1, Map) of
        {Key, Value} ->
            Value;
        false ->
            -1
    end.

remove(Key, Map) ->
    lists:keydelete(Key, 1, Map).