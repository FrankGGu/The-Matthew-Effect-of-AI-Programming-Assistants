-module(lfu_cache).
-export([new/1, get/2, put/2]).

-record(cache, {capacity, min_freq, freq_map, key_map}).

new(Capacity) ->
    #cache{capacity = Capacity, min_freq = 0, freq_map = maps:new(), key_map = maps:new()}.

get(_Cache, _Key) -> 0.

put(_Cache, _Key, _Value) -> ok.