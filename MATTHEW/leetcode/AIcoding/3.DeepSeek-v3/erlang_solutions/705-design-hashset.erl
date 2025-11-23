-module(hash_set).
-export([init/0, add/1, remove/1, contains/1]).

-record(hash_set, {table = gb_trees:empty()}).

init() ->
    #hash_set{}.

add(Key) ->
    fun(#hash_set{table = Table} = Set) ->
        case gb_trees:is_defined(Key, Table) of
            true -> Set;
            false -> Set#hash_set{table = gb_trees:insert(Key, true, Table)}
        end
    end.

remove(Key) ->
    fun(#hash_set{table = Table} = Set) ->
        case gb_trees:is_defined(Key, Table) of
            true -> Set#hash_set{table = gb_trees:delete(Key, Table)};
            false -> Set
        end
    end.

contains(Key) ->
    fun(#hash_set{table = Table}) ->
        gb_trees:is_defined(Key, Table)
    end.