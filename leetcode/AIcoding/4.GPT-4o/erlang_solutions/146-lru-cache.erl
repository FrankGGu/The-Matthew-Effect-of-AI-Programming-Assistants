%% LRU Cache implementation
%% -record(lru_cache, {capacity, cache_map, order_list}).
%%   - cache_map is a map of key-value pairs.
%%   - order_list is a doubly linked list tracking the order of usage.

%% Initialize LRU Cache with capacity.
-spec lru_cache_init_(Capacity :: integer()) -> any().
lru_cache_init_(Capacity) ->
    % Initialize the cache with the given capacity
    % The cache_map will store the key-value pairs and the order_list will keep track of usage
    % Here we're assuming an empty cache at first.
    {ok, #lru_cache{capacity = Capacity, cache_map = #{}, order_list = []}}.

%% Get the value for a given key from the cache. If the key doesn't exist, return -1.
-spec lru_cache_get(Key :: integer(), Cache :: #lru_cache{}) -> integer().
lru_cache_get(Key, #lru_cache{cache_map = CacheMap, order_list = OrderList}) ->
    case maps:find(Key, CacheMap) of
        {ok, Value} -> 
            % Update the order list by moving the accessed key to the front (most recent)
            {Value, #lru_cache{cache_map = CacheMap, order_list = [Key | lists:delete(Key, OrderList)]}};
        error -> 
            -1
    end.

%% Put a new key-value pair into the cache. If the cache exceeds capacity, evict the least recently used key.
-spec lru_cache_put(Key :: integer(), Value :: integer(), Cache :: #lru_cache{}) -> any().
lru_cache_put(Key, Value, #lru_cache{capacity = Capacity, cache_map = CacheMap, order_list = OrderList}) ->
    % If the key exists, update its value and move it to the front (most recent)
    case maps:find(Key, CacheMap) of
        {ok, _} -> 
            % Update the key's value and move it to the front
            NewCacheMap = maps:put(Key, Value, CacheMap),
            NewOrderList = [Key | lists:delete(Key, OrderList)];
        error -> 
            % If the key doesn't exist, add it to the cache
            NewCacheMap = maps:put(Key, Value, CacheMap),
            NewOrderList = [Key | OrderList]
    end,
    % If the cache exceeds capacity, evict the least recently used (LRU) key
    if
        length(NewOrderList) > Capacity ->
            OldestKey = lists:last(NewOrderList),
            NewCacheMap2 = maps:remove(OldestKey, NewCacheMap),
            NewOrderList2 = lists:delete(OldestKey, NewOrderList),
            {ok, #lru_cache{capacity = Capacity, cache_map = NewCacheMap2, order_list = NewOrderList2}};
        true ->
            {ok, #lru_cache{capacity = Capacity, cache_map = NewCacheMap, order_list = NewOrderList}}
    end.
