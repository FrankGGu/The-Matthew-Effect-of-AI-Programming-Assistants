-module(lru_cache).
-export([new/1, get/2, put/3]).

-record(cache, {capacity, map, head, tail}).

new(Capacity) ->
    #cache{capacity = Capacity, map = dict:new(), head = nil, tail = nil}.

get(_, nil) ->
    -1;
get(Key, Cache) ->
    case dict:find(Key, Cache#cache.map) of
        {ok, Node} ->
            update_order(Node, Cache),
            Node#node.value;
        error ->
            -1
    end.

put(_, _, nil) ->
    ok;
put(Key, Value, Cache) ->
    case dict:find(Key, Cache#cache.map) of
        {ok, Node} ->
            Node#node.value = Value,
            update_order(Node, Cache);
        error ->
            NewNode = #node{key = Key, value = Value, prev = nil, next = Cache#cache.head},
            case Cache#cache.head of
                nil ->
                    Cache#cache{head = NewNode, tail = NewNode, map = dict:store(Key, NewNode, Cache#cache.map)};
                _ ->
                    Cache#cache.head#node.prev = NewNode,
                    Cache#cache{head = NewNode, map = dict:store(Key, NewNode, Cache#cache.map)}
            end,
            if
                erlang:size(Cache#cache.map) > Cache#cache.capacity ->
                    remove_tail(Cache);
                true ->
                    ok
            end
    end.

update_order(Node, Cache) ->
    case Node#node.prev of
        nil ->
            ok;
        _ ->
            Node#node.prev#node.next = Node#node.next
    end,
    case Node#node.next of
        nil ->
            Cache#cache{tail = Node#node.prev};
        _ ->
            Node#node.next#node.prev = Node#node.prev
    end,
    Node#node.next = Cache#cache.head,
    case Cache#cache.head of
        nil ->
            Cache#cache{head = Node, tail = Node};
        _ ->
            Cache#cache.head#node.prev = Node,
            Cache#cache{head = Node}
    end.

remove_tail(Cache) ->
    Tail = Cache#cache.tail,
    case Tail#node.prev of
        nil ->
            Cache#cache{head = nil, tail = nil, map = dict:erase(Tail#node.key, Cache#cache.map)};
        Prev ->
            Prev#node.next = nil,
            Cache#cache{tail = Prev, map = dict:erase(Tail#node.key, Cache#cache.map)}
    end.