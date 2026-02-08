-module(my_hash_set).
-export([new/0, add/2, remove/2, contains/2]).

new() ->
    {dict, dict:new()}.

add(Key, {dict, D}) ->
    {dict, dict:store(Key, true, D)}.

remove(Key, {dict, D}) ->
    {dict, dict:erase(Key, D)}.

contains(Key, {dict, D}) ->
    dict:is_key(Key, D).