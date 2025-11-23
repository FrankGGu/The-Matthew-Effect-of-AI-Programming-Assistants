-module(lfu_cache).
-export([new/1, get/2, put/3]).

new(Capacity) ->
    #{
        capacity => Capacity,
        size => 0,
        key_to_info => #{},
        freq_to_keys_ts => gb_trees:empty()
    }.

get(Key, State) ->
    KeyToInfo = maps:get(key_to_info, State),
    FreqToKeysTs = maps:get(freq_to_keys_ts, State),

    case maps:get(Key, KeyToInfo, not_found) of
        not_found ->
            {not_found, State};
        #{val := Value, freq := OldFreq, ts := OldTs} ->
            NewFreq = OldFreq + 1,
            NewTs = erlang:monotonic_time(nanosecond),

            UpdatedKeyInfo = #{val => Value, freq => NewFreq, ts => NewTs},
            NewKeyToInfo = maps:put(Key, UpdatedKeyInfo, KeyToInfo),

            NewFreqToKeysTs1 = gb_trees:delete({OldFreq, OldTs}, FreqToKeysTs),
            NewFreqToKeysTs2 = gb_trees:insert({NewFreq, NewTs}, Key, NewFreqToKeysTs1),

            NewState = maps:put(key_to_info, NewKeyToInfo, maps:put(freq_to_keys_ts, NewFreqToKeysTs2, State)),
            {ok, Value, NewState}
    end.

put(Key, Value, State) ->
    Capacity = maps:get(capacity, State),
    Size = maps:get(size, State),
    KeyToInfo = maps:get(key_to_info, State),
    FreqToKeysTs = maps:get(freq_to_keys_ts, State),

    if Capacity == 0 ->
        State;
    true ->
        case maps:get(Key, KeyToInfo, not_found) of
            not_found ->
                {NewKeyToInfo0, NewFreqToKeysTs0, NewSize0} = 
                    if Size == Capacity ->
                        {EvictKeyTuple, EvictKey} = gb_trees:smallest(FreqToKeysTs),
                        {EvictFreq, EvictTs} = EvictKeyTuple,

                        NewKeyToInfo1 = maps:remove(EvictKey, KeyToInfo),
                        NewFreqToKeysTs1 = gb_trees:delete({EvictFreq, EvictTs}, FreqToKeysTs),

                        {NewKeyToInfo1, NewFreqToKeysTs1, Size - 1};
                    true ->
                        {KeyToInfo, FreqToKeysTs, Size}
                    end,

                NewFreq = 1,
                NewTs = erlang:monotonic_time(nanosecond),

                NewKeyInfo = #{val => Value, freq => NewFreq, ts => NewTs},
                NewKeyToInfo = maps:put(Key, NewKeyInfo, NewKeyToInfo0),
                NewFreqToKeysTs = gb_trees:insert({NewFreq, NewTs}, Key, NewFreqToKeysTs0),

                maps:put(size, NewSize0 + 1, maps:put(key_to_info, NewKeyToInfo, maps:put(freq_to_keys_ts, NewFreqToKeysTs, State)));

            #{val := OldVal, freq := OldFreq, ts := OldTs} ->
                NewFreq = OldFreq + 1,
                NewTs = erlang:monotonic_time(nanosecond),

                UpdatedKeyInfo = #{val => Value, freq => NewFreq, ts => NewTs},
                NewKeyToInfo = maps:put(Key, UpdatedKeyInfo, KeyToInfo),

                NewFreqToKeysTs1 = gb_trees:delete({OldFreq, OldTs}, FreqToKeysTs),
                NewFreqToKeysTs2 = gb_trees:insert({NewFreq, NewTs}, Key, NewFreqToKeysTs1),

                maps:put(key_to_info, NewKeyToInfo, maps:put(freq_to_keys_ts, NewFreqToKeysTs2, State))
        end
    end.