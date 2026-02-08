-module(my_hash_map).
-export([new/0, put/3, get/2, remove/2]).

new() ->
    {dict, dict:new()}.

put(Key, Value, {dict, D}) ->
    {dict, dict:store(Key, Value, D)}.

get(Key, {dict, D}) ->
    case dict:find(Key, D) of
        {ok, V} -> V;
        error -> -1
    end.

remove(Key, {dict, D}) ->
    {dict, dict:erase(Key, D)}.