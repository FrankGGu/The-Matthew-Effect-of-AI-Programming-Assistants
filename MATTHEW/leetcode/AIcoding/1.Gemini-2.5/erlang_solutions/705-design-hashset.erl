-module(my_hash_set).
-export([new/0, add/2, remove/2, contains/2]).

new() ->
    %% Create an ETS table of type 'set'.
    %% 'set' ensures that keys are unique, which is the core property of a hash set.
    %% We store {Key, true} tuples, where Key is the element of the set.
    ets:new(my_hash_set_table, [set, public]).

add(TableId, Key) ->
    %% Insert the key into the ETS table.
    %% For 'set' tables, ets:insert/2 expects a {Key, Value} tuple.
    %% We use 'true' as a dummy value since we only care about the presence of the key.
    ets:insert(TableId, {Key, true}).

remove(TableId, Key) ->
    %% Delete the key from the ETS table.
    ets:delete(TableId, Key).

contains(TableId, Key) ->
    %% Lookup the key in the ETS table.
    %% ets:lookup/2 returns a list of {Key, Value} tuples if found, or an empty list [] if not found.
    case ets:lookup(TableId, Key) of
        [] -> false; %% Key not found
        _  -> true   %% Key found
    end.