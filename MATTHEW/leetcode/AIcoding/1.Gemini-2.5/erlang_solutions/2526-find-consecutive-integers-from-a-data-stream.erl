-module(solution).
-behaviour(gen_server).

-export([new/2, consec/2]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
    value :: integer(),
    k :: integer(),
    count :: integer()
}).

new(Value, K) ->
    {ok, Pid} = gen_server:start_link(?MODULE, [Value, K], []),
    Pid.

consec(Pid, Num) ->
    gen_server:call(Pid, {check, Num}).

init([Value, K]) ->
    {ok, #state{value = Value, k = K, count = 0}}.

handle_call({check, Num}, _From, State) ->
    #state{value = Value, k = K, count = CurrentCount} = State,
    NewCount =
        if
            Num == Value -> CurrentCount + 1;
            true -> 0
        end,
    IsConsecutive = (NewCount >= K),
    NewState = State#state{count = NewCount},
    {reply, IsConsecutive, NewState}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.