-module(max_freq_stack).
-export([max_freq_stack/0, push/2, pop/0]).

-record(state, {freq = #{}, max_freq = 0, stack = #{}}).

max_freq_stack() ->
    State = #state{},
    loop(State).

push(X, State) ->
    Freq = maps:get(X, State#state.freq, 0) + 1,
    NewMaxFreq = max(Freq, State#state.max_freq),
    NewFreqMap = maps:put(X, Freq, State#state.freq),
    NewStack = maps:update_with(Freq, fun(Stack) -> [X | Stack] end, [X], State#state.stack),
    NewState = State#state{freq = NewFreqMap, max_freq = NewMaxFreq, stack = NewStack},
    {ok, NewState}.

pop(State) ->
    case maps:get(State#state.max_freq, State#state.stack, []) of
        [] -> 
            {error, empty};
        [X | Rest] ->
            NewFreq = maps:get(X, State#state.freq) - 1,
            NewFreqMap = maps:put(X, NewFreq, State#state.freq),
            NewStack = maps:put(State#state.max_freq, Rest, State#state.stack),
            NewMaxFreq = if NewFreq == 0 -> State#state.max_freq; true -> State#state.max_freq end,
            NewState = State#state{freq = NewFreqMap, max_freq = NewMaxFreq, stack = NewStack},
            {ok, X, NewState}
    end.

loop(State) ->
    receive
        {push, X} ->
            {ok, NewState} = push(X, State),
            loop(NewState);
        pop ->
            {ok, X, NewState} = pop(State),
            loop(NewState);
        stop ->
            ok
    end.