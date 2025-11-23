-module(lru_cache).
-export([lru_cache/1, get/2, put/3]).

-record(node, {key, value, prev = undefined, next = undefined}).
-record(lru_cache, {capacity, map = #{}, head = undefined, tail = undefined}).

lru_cache(Capacity) ->
    #lru_cache{capacity = Capacity}.

get(Cache, Key) ->
    case maps:is_key(Key, Cache#lru_cache.map) of
        true ->
            Node = maps:get(Key, Cache#lru_cache.map),
            Cache1 = remove(Cache, Node),
            Cache2 = add(Cache1, Node),
            {Cache2, Node#node.value};
        false ->
            {Cache, -1}
    end.

put(Cache, Key, Value) ->
    case maps:is_key(Key, Cache#lru_cache.map) of
        true ->
            Node = maps:get(Key, Cache#lru_cache.map),
            Cache1 = remove(Cache, Node),
            Cache2 = add(Cache1, Node#node{value = Value}),
            Cache3 = Cache2#lru_cache{map = maps:put(Key, Cache2#lru_cache.tail, Cache2#lru_cache.map)};
            Cache3;
        false ->
            if
                maps:size(Cache#lru_cache.map) < Cache#lru_cache.capacity ->
                    Cache2 = add(Cache, #node{key = Key, value = Value}),
                    Cache2#lru_cache{map = maps:put(Key, Cache2#lru_cache.tail, Cache2#lru_cache.map)};
                true ->
                    {OldKey, OldNode} = remove_last(Cache),
                    Cache1 = remove(Cache, OldNode),
                    Cache2 = add(Cache1, #node{key = Key, value = Value}),
                    Cache2#lru_cache{map = maps:put(Key, Cache2#lru_cache.tail, Cache2#lru_cache.map)}
            end
    end.

remove(Cache, Node) ->
    Prev = Node#node.prev,
    Next = Node#node.next,
    NewHead = if Prev =:= undefined -> Cache#lru_cache.head; true -> Prev end,
    NewTail = if Next =:= undefined -> Cache#lru_cache.tail; true -> Next end,
    case Prev of
        undefined -> ok;
        _ -> Prev#node.next = Next
    end,
    case Next of
        undefined -> ok;
        _ -> Next#node.prev = Prev
    end,
    Cache#lru_cache{head = NewHead, tail = NewTail}.

add(Cache, Node) ->
    Node#node.prev = undefined,
    Node#node.next = Cache#lru_cache.head,
    case Cache#lru_cache.head of
        undefined -> 
            Cache#lru_cache{head = Node, tail = Node};
        _ ->
            Cache#lru_cache{head = Node#node{next = Cache#lru_cache.head}} 
    end.

remove_last(Cache) ->
    case Cache#lru_cache.tail of
        undefined -> {undefined, undefined};
        Node ->
            Key = Node#node.key,
            {Key, Node}
    end.