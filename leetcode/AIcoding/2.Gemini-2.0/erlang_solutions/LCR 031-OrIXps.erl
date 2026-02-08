-module(lru_cache).
-export([new/1, get/2, put/3]).

new(Capacity) ->
    {Capacity, dict:new(), []}.

get({Capacity, Cache, LRU}, Key) ->
    case dict:find(Key, Cache) of
        {ok, Value} ->
            NewLRU = [Key | lists:delete(Key, LRU)],
            {{Capacity, Cache, NewLRU}, Value};
        error ->
            {{Capacity, Cache, LRU}, -1}
    end.

put({Capacity, Cache, LRU}, Key, Value) ->
    case dict:is_key(Key, Cache) of
        true ->
            NewCache = dict:store(Key, Value, Cache),
            NewLRU = [Key | lists:delete(Key, LRU)],
            {Capacity, NewCache, NewLRU};
        false ->
            case length(LRU) >= Capacity of
                true ->
                    OldestKey = lists:last(LRU),
                    NewCache = dict:erase(OldestKey, Cache),
                    NewCache2 = dict:store(Key, Value, NewCache),
                    NewLRU = [Key | lists:delete(OldestKey, LRU)],
                    {Capacity, NewCache2, NewLRU};
                false ->
                    NewCache = dict:store(Key, Value, Cache),
                    NewLRU = [Key | LRU],
                    {Capacity, NewCache, NewLRU}
            end
    end.