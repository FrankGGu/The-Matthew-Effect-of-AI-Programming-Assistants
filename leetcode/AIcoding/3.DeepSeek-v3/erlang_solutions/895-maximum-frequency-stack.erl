-module(max_freq_stack).
-export([init/0, push/2, pop/1]).

-record(state, {
    freq = maps:new(),
    group = maps:new(),
    max_freq = 0
}).

init() ->
    #state{}.

push(State, Val) ->
    Freq = maps:get(Val, State#state.freq, 0) + 1,
    NewFreq = maps:put(Val, Freq, State#state.freq),
    Group = State#state.group,
    NewGroup = case maps:is_key(Freq, Group) of
        true -> 
            Stack = maps:get(Freq, Group),
            maps:put(Freq, [Val | Stack], Group);
        false -> 
            maps:put(Freq, [Val], Group)
    end,
    MaxFreq = max(State#state.max_freq, Freq),
    State#state{freq = NewFreq, group = NewGroup, max_freq = MaxFreq}.

pop(State) ->
    MaxFreq = State#state.max_freq,
    Group = State#state.group,
    [Val | Stack] = maps:get(MaxFreq, Group),
    NewGroup = case Stack of
        [] -> 
            maps:remove(MaxFreq, Group);
        _ -> 
            maps:put(MaxFreq, Stack, Group)
    end,
    Freq = State#state.freq,
    NewFreq = maps:put(Val, maps:get(Val, Freq) - 1, Freq),
    NewMaxFreq = case NewGroup of
        #{MaxFreq := _} -> MaxFreq;
        _ -> MaxFreq - 1
    end,
    {Val, State#state{freq = NewFreq, group = NewGroup, max_freq = NewMaxFreq}}.