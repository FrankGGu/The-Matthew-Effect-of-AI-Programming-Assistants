-module(auth_manager).
-export([new/0, generate/2, renew/2, count_unexpired/1]).

-record(state, {tokens = #{}}).

new() ->
    start().

generate(Id, Time) ->
    State = get_state(),
    Tokens = maps:update(Id, Time, fun(_) -> Time end, State#state.tokens),
    set_state(State#state{tokens = Tokens}).

renew(Id, Time) ->
    State = get_state(),
    case maps:get(Id, State#state.tokens, undefined) of
        undefined -> ok;
        Expiration when Expiration > Time ->
            Tokens = maps:put(Id, Time + 5 * 60, State#state.tokens),
            set_state(State#state{tokens = Tokens}),
            ok;
        _ -> ok
    end.

count_unexpired(Time) ->
    State = get_state(),
    Tokens = maps:fold(fun(_, Expiration, Acc) ->
        if
            Expiration > Time -> Acc + 1;
            true -> Acc
        end
    end, 0, State#state.tokens).

start() ->
    register(auth_manager, spawn(fun() -> loop(#state{}) end)).

loop(State) ->
    receive
        {generate, Id, Time} ->
            NewState = generate(Id, Time, State),
            loop(NewState);
        {renew, Id, Time} ->
            NewState = renew(Id, Time, State),
            loop(NewState);
        {count_unexpired, Time, Caller} ->
            Count = count_unexpired(Time, State),
            Caller ! Count,
            loop(State)
    end.

get_state() ->
    auth_manager ! {get_state, self()},
    receive
        State -> State
    end.

set_state(State) ->
    auth_manager ! {set_state, State},
    ok.

generate(Id, Time, State) ->
    Tokens = maps:update(Id, Time, fun(_) -> Time end, State#state.tokens),
    #state{tokens = Tokens}.

renew(Id, Time, State) ->
    case maps:get(Id, State#state.tokens, undefined) of
        undefined -> State;
        Expiration when Expiration > Time ->
            Tokens = maps:put(Id, Time + 5 * 60, State#state.tokens),
            #state{tokens = Tokens};
        _ -> State
    end.

count_unexpired(Time, State) ->
    maps:fold(fun(_, Expiration, Acc) ->
        if
            Expiration > Time -> Acc + 1;
            true -> Acc
        end
    end, 0, State#state.tokens).