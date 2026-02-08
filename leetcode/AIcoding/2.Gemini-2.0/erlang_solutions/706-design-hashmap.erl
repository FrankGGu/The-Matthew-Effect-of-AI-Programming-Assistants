-module(hashmap).
-export([new/0, put/3, get/2, remove/2]).

new() ->
    {dict:new(), 0}.

put(Map, Key, Value) ->
    {Dict, Count} = Map,
    case dict:is_key(Key, Dict) of
        true ->
            {dict:store(Key, Value, Dict), Count};
        false ->
            {dict:store(Key, Value, Dict), Count + 1}
    end.

get(Map, Key) ->
    {Dict, _} = Map,
    case dict:find(Key, Dict) of
        {ok, Value} ->
            Value;
        error ->
            -1
    end.

remove(Map, Key) ->
    {Dict, Count} = Map,
    case dict:is_key(Key, Dict) of
        true ->
            {dict:erase(Key, Dict), Count - 1};
        false ->
            Map
    end.