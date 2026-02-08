-module(insert_delete_getrandom_o1).
-export([new/0, insert/2, delete/2, get_random/1]).

new() ->
    {dict:new(), dict:new(), 0}.

insert(Key, Value, {Map, IndexMap, Count}) ->
    case dict:is_key(Key, Map) of
        true ->
            {Map, IndexMap, Count};
        false ->
            NewMap = dict:store(Key, Value, Map),
            NewIndexMap = dict:store(Count, Key, IndexMap),
            {NewMap, NewIndexMap, Count + 1}
    end.

delete(Key, {Map, IndexMap, Count}) ->
    case dict:is_key(Key, Map) of
        true ->
            {Value, NewMap} = dict:take(Key, Map),
            [LastKey] = dict:keys(IndexMap),
            LastIndex = dict:fetch(LastKey, IndexMap),
            NewIndexMap = dict:store(LastIndex, LastKey, dict:remove(Count - 1, IndexMap)),
            {Value, NewMap, NewIndexMap, Count - 1};
        false ->
            {undefined, Map, IndexMap, Count}
    end.

get_random({Map, IndexMap, Count}) ->
    RandomIndex = rand:uniform(Count) - 1,
    Key = dict:fetch(RandomIndex, IndexMap),
    dict:fetch(Key, Map).