-module(hash_set).
-export([new/0, add/2, remove/2, contains/2]).

new() ->
    ordsets:new().

add(Set, Key) ->
    ordsets:add_element(Key, Set).

remove(Set, Key) ->
    ordsets:del_element(Key, Set).

contains(Set, Key) ->
    ordsets:is_element(Key, Set).