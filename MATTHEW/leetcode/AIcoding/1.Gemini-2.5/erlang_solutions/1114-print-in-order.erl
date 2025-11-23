-module(foo).
-behaviour(gen_server).

-export([start_link/0, first/1, second/1, third/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(foo_state, {first_done = false, second_done = false,
                     waiters_for_first = [],
                     waiters_for_second = []
                    }).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

first(PrintFun) ->
    PrintFun(),
    gen_server:cast(?MODULE, first_completed).

second(PrintFun) ->
    ok = gen_server:call(?MODULE, {wait_for_first, self()}),
    PrintFun(),
    gen_server:cast(?MODULE, second_completed).

third(PrintFun) ->
    ok = gen_server:call(?MODULE, {wait_for_second, self()}),
    PrintFun().

init([]) ->
    {ok, #foo_state{}}.

handle_call({wait_for_first, _Caller}, _From, State = #foo_state{first_done = true}) ->
    {reply, ok, State};
handle_call({wait_for_first, Caller}, From, State = #foo_state{first_done = false, waiters_for_first = Waiters}) ->
    {noreply, State#foo_state{waiters_for_first = [{From, Caller} | Waiters]}};

handle_call({wait_for_second, _Caller}, _From, State = #foo_state{second_done = true}) ->
    {reply, ok, State};
handle_call({wait_for_second, Caller}, From, State = #foo_state{second_done = false, waiters_for_second = Waiters}) ->
    {noreply, State#foo_state{waiters_for_second = [{From, Caller} | Waiters]}};

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(first_completed, State = #foo_state{waiters_for_first = Waiters}) ->
    lists:foreach(fun({From, _Caller}) -> gen_server:reply(From, ok) end, Waiters),
    {noreply, State#foo_state{first_done = true, waiters_for_first = []}};

handle_cast(second_completed, State = #foo_state{waiters_for_second = Waiters}) ->
    lists:foreach(fun({From, _Caller}) -> gen_server:reply(From, ok) end, Waiters),
    {noreply, State#foo_state{second_done = true, waiters_for_second = []}};

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.