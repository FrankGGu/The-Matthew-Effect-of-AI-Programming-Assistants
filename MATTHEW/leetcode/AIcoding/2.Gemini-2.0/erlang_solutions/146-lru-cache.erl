-module(lru_cache).
-export([new/1, get/2, put/3]).

new(Capacity) ->
    {orddict:new(), Capacity, 0}.

get({Cache, Capacity, Size}, Key) ->
    case orddict:find(Key, Cache) of
        {ok, Value} ->
            NewCache = orddict:erase(Key, Cache),
            NewCache2 = orddict:store(Key, Value, NewCache),
            {NewCache2, Capacity, Size},
            {ok, Value};
        error ->
            {{Cache, Capacity, Size}, -1}
    end.

put({Cache, Capacity, Size}, Key, Value) ->
    case orddict:find(Key, Cache) of
        {ok, _} ->
            NewCache = orddict:erase(Key, Cache),
            NewCache2 = orddict:store(Key, Value, NewCache),
            {NewCache2, Capacity, Size};
        error ->
            if Size < Capacity ->
                NewCache = orddict:store(Key, Value, Cache),
                {NewCache, Capacity, Size + 1};
            true ->
                {OldestKey, _} = orddict:fetch(orddict:smallest(Cache), Cache),
                NewCache = orddict:erase(OldestKey, Cache),
                NewCache2 = orddict:store(Key, Value, NewCache),
                {NewCache2, Capacity, Size}
            end
    end.