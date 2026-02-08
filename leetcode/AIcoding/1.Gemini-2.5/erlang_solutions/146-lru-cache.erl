-module(lru_cache).

-behaviour(gen_server).

-export([new/1, get/2, put/3]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
    capacity :: integer(),
    size :: integer(),
    ets_table :: ets:tid(),
    head_key :: any() | undefined, % Key of the Most Recently Used (MRU) node
    tail_key :: any() | undefined  % Key of the Least Recently Used (LRU) node
}).

new(Capacity) ->
    gen_server:start_link(?MODULE, [Capacity], []).

get(Pid, Key) ->
    gen_server:call(Pid, {get, Key}).

put(Pid, Key, Value) ->
    gen_server:call(Pid, {put, Key, Value}).

init([Capacity]) ->
    Table = ets:new(lru_cache_ets, [set, public, {read_concurrency, true}]),
    {ok, #state{capacity = Capacity, size = 0, ets_table = Table, head_key = undefined, tail_key = undefined}}.

handle_call({get, Key}, _From, State) ->
    #state{ets_table = Table} = State,
    case ets:lookup(Table, Key) of
        [] ->
            {reply, -1, State};
        [{Key, Value, PrevK, NextK}] ->
            NewState = move_to_head(Key, Value, PrevK, NextK, State),
            {reply, Value, NewState}
    end;

handle_call({put, Key, Value}, _From, State) ->
    #state{ets_table = Table} = State,
    case ets:lookup(Table, Key) of
        [] -> % Key not found, add new
            NewState1 = if State#state.size == State#state.capacity ->
                            remove_tail(State);
                        else ->
                            State
                        end,
            NewState2 = add_new_head(Key, Value, NewState1),
            {reply, ok, NewState2};
        [{Key, _OldValue, PrevK, NextK}] -> % Key found, update value and move to head
            ets:insert(Table, {Key, Value, PrevK, NextK}), % Update value
            NewState = move_to_head(Key, Value, PrevK, NextK, State),
            {reply, ok, NewState}
    end;

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, #state{ets_table = Table}) ->
    ets:delete(Table),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

move_to_head(Key, Value, PrevK, NextK, #state{ets_table = Table, head_key = HeadK, tail_key = TailK} = State) ->
    % If Key is already the head, no change needed in list order
    if Key == HeadK ->
        State;
    else
        % 1. Disconnect Key from its current position
        if PrevK /= undefined ->
            ets:update_element(Table, PrevK, {4, NextK}); % Update PrevK's NextKey (pos 4) to Key's NextKey
        true ->
            ok
        end,
        if NextK /= undefined ->
            ets:update_element(Table, NextK, {3, PrevK}); % Update NextK's PrevKey (pos 3) to Key's PrevKey
        true ->
            ok
        end,

        % 2. Handle TailK update if Key was the TailK
        NewTailK = if Key == TailK -> PrevK; else -> TailK end,
        NewState1 = State#state{tail_key = NewTailK},

        % 3. Connect Key to the head
        ets:update_element(Table, HeadK, {3, Key}), % Update current HeadK's PrevKey (pos 3) to Key
        ets:insert(Table, {Key, Value, undefined, HeadK}), % Key is now head, its PrevKey is undefined, NextKey is old HeadK

        % 4. Update HeadK in state
        NewState1#state{head_key = Key}
    end.

add_new_head(Key, Value, #state{ets_table = Table, head_key = HeadK, size = Size} = State) ->
    if Size == 0 -> % First element
        ets:insert(Table, {Key, Value, undefined, undefined}),
        State#state{size = 1, head_key = Key, tail_key = Key};
    else % Add to existing list
        ets:insert(Table, {Key, Value, undefined, HeadK}),
        ets:update_element(Table, HeadK, {3, Key}), % Update current HeadK's PrevKey (pos 3) to Key
        State#state{size = Size + 1, head_key = Key}
    end.

remove_tail(#state{ets_table = Table, tail_key = TailK, size = Size} = State) ->
    % Lookup TailK to get its PrevK before deleting
    [{TailK, _Value, PrevK, _NextK}] = ets:lookup(Table, TailK),
    ets:delete(Table, TailK),

    NewTailK = if PrevK /= undefined ->
                    ets:update_element(Table, PrevK, {4, undefined}), % New tail's NextKey (pos 4) is undefined
                    PrevK;
                else % If PrevK is undefined, it means TailK was the only element.
                    undefined % Now the list is empty.
                end,
    State#state{size = Size - 1, tail_key = NewTailK}.