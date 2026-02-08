-module(lfu_cache).
-export([new/1, get/2, put/3]).

-record(state, {
    capacity,
    size = 0,
    cache = #{},
    freq_map = #{1 => []},
    min_freq = 1
}).

new(Capacity) ->
    #state{capacity = Capacity, cache = #{}, freq_map = #{1 => []}, min_freq = 1}.

get(Key, State = #state{cache = Cache, freq_map = FreqMap, min_freq = MinFreq}) ->
    case maps:get(Key, Cache, undefined) of
        undefined ->
            {undefined, State};
        {Value, Freq} ->
            NewFreq = Freq + 1;
            NewFreqMap = update_freq_map(Key, Freq, NewFreq, FreqMap);
            NewCache = maps:put(Key, {Value, NewFreq}, Cache);
            case length(maps:get(MinFreq, FreqMap)) == 0 and MinFreq == Freq of
                true ->
                    {Value, State#state{cache = NewCache, freq_map = NewFreqMap, min_freq = NewFreq}};
                false ->
                    {Value, State#state{cache = NewCache, freq_map = NewFreqMap}};
            end
    end.

put(Key, Value, State = #state{capacity = Capacity, size = Size, cache = Cache, freq_map = FreqMap, min_freq = MinFreq}) ->
    case maps:get(Key, Cache, undefined) of
        {_, Freq} ->
            NewFreq = Freq + 1;
            NewFreqMap = update_freq_map(Key, Freq, NewFreq, FreqMap);
            NewCache = maps:put(Key, {Value, NewFreq}, Cache);
            {ok, State#state{cache = NewCache, freq_map = NewFreqMap}};
        undefined ->
            if Size >= Capacity ->
                {VictimKey, NewFreqMap1} = evict(FreqMap, MinFreq);
                NewCache = maps:remove(VictimKey, Cache);
                NewCache1 = maps:put(Key, {Value, 1}, NewCache);
                NewFreqMap = maps:update(1, [Key], maps:put(1, [Key], NewFreqMap1));
                {ok, State#state{cache = NewCache1, freq_map = NewFreqMap, size = Size, min_freq = 1}};
            true ->
                NewCache = maps:put(Key, {Value, 1}, Cache);
                NewFreqMap = maps:update(1, [Key], maps:put(1, [Key], FreqMap));
                {ok, State#state{cache = NewCache, freq_map = NewFreqMap, size = Size + 1, min_freq = 1}}
            end
    end.

update_freq_map(Key, OldFreq, NewFreq, FreqMap) ->
    OldFreqList = maps:get(OldFreq, FreqMap);
    NewFreqList = maps:get(NewFreq, FreqMap, []);
    NewOldFreqList = lists:delete(Key, OldFreqList);
    NewNewFreqList = [Key | NewFreqList];
    NewFreqMap1 = maps:put(OldFreq, NewOldFreqList, FreqMap);
    maps:put(NewFreq, NewNewFreqList, NewFreqMap1).

evict(FreqMap, MinFreq) ->
    VictimList = maps:get(MinFreq, FreqMap);
    VictimKey = lists:nth(1, VictimList);
    NewVictimList = lists:delete(VictimKey, VictimList);
    NewFreqMap = maps:put(MinFreq, NewVictimList, FreqMap);
    {VictimKey, NewFreqMap}.