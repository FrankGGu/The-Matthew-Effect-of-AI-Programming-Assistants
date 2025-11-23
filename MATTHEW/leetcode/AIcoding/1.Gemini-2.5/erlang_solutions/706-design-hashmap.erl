-module(my_hash_map).
-export([new/0, put/3, get/2, remove/2]).

new() ->
    ets:new(my_map_table, [set, public, {read_concurrency, true}]).

put(Table, Key, Value) ->
    ets:insert(Table, {Key, Value}).

get(Table, Key) ->
    case ets:lookup(Table, Key) of
        [{_Key, Value}] -> Value;
        [] -> -1
    end.

remove(Table, Key) ->
    ets:delete(Table, Key).