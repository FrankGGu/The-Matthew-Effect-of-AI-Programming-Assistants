-module(lfu_cache).
-export([init/1, get/2, put/3]).

-record(node, {key, value, freq}).
-record(state, {capacity, min_freq, key_map, freq_map}).

init(Capacity) ->
    #state{
        capacity = Capacity,
        min_freq = 1,
        key_map = maps:new(),
        freq_map = maps:new()
    }.

get(Key, State) ->
    case maps:find(Key, State#state.key_map) of
        {ok, Node} ->
            update_freq(Node, State);
        error ->
            {-1, State}
    end.

put(Key, Value, State) ->
    case maps:find(Key, State#state.key_map) of
        {ok, Node} ->
            NewNode = Node#node{value = Value},
            NewState = State#state{key_map = maps:put(Key, NewNode, State#state.key_map)},
            update_freq(NewNode, NewState);
        error ->
            case State#state.capacity =< 0 of
                true ->
                    State;
                false ->
                    case maps:size(State#state.key_map) >= State#state.capacity of
                        true ->
                            MinFreq = State#state.min_freq,
                            {Nodes, NewFreqMap} = maps:take(MinFreq, State#state.freq_map),
                            {NodeToRemove, RestNodes} = queue:out(Nodes),
                            case queue:is_empty(RestNodes) of
                                true ->
                                    NewFreqMap2 = maps:remove(MinFreq, NewFreqMap),
                                    NewMinFreq = MinFreq + 1;
                                false ->
                                    NewFreqMap2 = maps:put(MinFreq, RestNodes, NewFreqMap),
                                    NewMinFreq = MinFreq
                            end,
                            #node{key = K} = NodeToRemove,
                            NewKeyMap = maps:remove(K, State#state.key_map),
                            NewState = State#state{
                                key_map = NewKeyMap,
                                freq_map = NewFreqMap2,
                                min_freq = NewMinFreq
                            },
                            do_put(Key, Value, NewState);
                        false ->
                            do_put(Key, Value, State)
                    end
            end
    end.

do_put(Key, Value, State) ->
    NewNode = #node{key = Key, value = Value, freq = 1},
    NewKeyMap = maps:put(Key, NewNode, State#state.key_map),
    NewFreqMap = case maps:find(1, State#state.freq_map) of
        {ok, Q} ->
            maps:put(1, queue:in(NewNode, Q), State#state.freq_map);
        error ->
            maps:put(1, queue:from_list([NewNode]), State#state.freq_map)
    end,
    NewState = State#state{
        key_map = NewKeyMap,
        freq_map = NewFreqMap,
        min_freq = 1
    },
    NewState.

update_freq(Node, State) ->
    #node{key = Key, value = Value, freq = Freq} = Node,
    OldQ = maps:get(Freq, State#state.freq_map),
    {value, _, NewQ} = queue:out(OldQ),
    NewFreqMap1 = case queue:is_empty(NewQ) of
        true ->
            case State#state.min_freq == Freq of
                true ->
                    State#state.min_freq = Freq + 1;
                false ->
                    ok
            end,
            maps:remove(Freq, State#state.freq_map);
        false ->
            maps:put(Freq, NewQ, State#state.freq_map)
    end,
    NewFreq = Freq + 1,
    NewNode = Node#node{freq = NewFreq},
    NewKeyMap = maps:put(Key, NewNode, State#state.key_map),
    NewFreqMap2 = case maps:find(NewFreq, NewFreqMap1) of
        {ok, Q} ->
            maps:put(NewFreq, queue:in(NewNode, Q), NewFreqMap1);
        error ->
            maps:put(NewFreq, queue:from_list([NewNode]), NewFreqMap1)
    end,
    NewState = State#state{
        key_map = NewKeyMap,
        freq_map = NewFreqMap2
    },
    {Value, NewState}.