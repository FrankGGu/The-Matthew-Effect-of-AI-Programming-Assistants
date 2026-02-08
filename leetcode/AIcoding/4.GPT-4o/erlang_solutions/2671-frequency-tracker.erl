-module(frequency_tracker).
-export([FrequencyTracker/0]).

-record(state, {frequency_map = #{}, frequency_count = #{}}).

init() ->
    #state{}.

add(frequency, State) ->
    FrequencyMap = State#state.frequency_map,
    FrequencyCount = State#state.frequency_count,
    NewFrequencyMap = maps:update_with(frequency, fun(X) -> X + 1 end, 1, FrequencyMap),
    Count = maps:get(frequency, FrequencyMap, 0),
    NewFrequencyCount = if Count > 0 -> 
        FrequencyCount1 = maps:update_with(Count, fun(X) -> X - 1 end, 0, FrequencyCount),
        FrequencyCount2 = maps:put(Count + 1, maps:get(Count, FrequencyCount, 0) + 1, FrequencyCount1)
    end,
    State#state{frequency_map = NewFrequencyMap, frequency_count = NewFrequencyCount}.

delete(frequency, State) ->
    FrequencyMap = State#state.frequency_map,
    FrequencyCount = State#state.frequency_count,
    case maps:get(frequency, FrequencyMap, 0) of
        0 -> State;
        Count -> 
            NewFrequencyMap = maps:update(frequency, fun(X) -> X - 1 end, FrequencyMap),
            NewFrequencyCount = if Count > 1 -> 
                FrequencyCount1 = maps:update_with(Count, fun(X) -> X - 1 end, 0, FrequencyCount),
                FrequencyCount2 = maps:put(Count - 1, maps:get(Count - 1, FrequencyCount, 0) + 1, FrequencyCount1)
            end,
            State#state{frequency_map = NewFrequencyMap, frequency_count = NewFrequencyCount}
    end.

get_count(frequency, State) ->
    FrequencyCount = State#state.frequency_count,
    maps:get(frequency, FrequencyCount, 0).

FrequencyTracker() ->
    State = init(),
    {State, fun(Freq) -> State = add(Freq, State), State end,
     fun(Freq) -> State = delete(Freq, State), State end,
     fun(Freq) -> get_count(Freq, State) end}.