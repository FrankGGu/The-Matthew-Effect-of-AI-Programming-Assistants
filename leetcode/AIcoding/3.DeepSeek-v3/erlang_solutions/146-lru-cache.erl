-module(lru_cache).
-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/1, get/2, put/3]).

-record(state, {capacity, size = 0, map = #{}, list = []}).

start_link(Capacity) ->
    gen_server:start_link(?MODULE, [Capacity], []).

get(Pid, Key) ->
    gen_server:call(Pid, {get, Key}).

put(Pid, Key, Value) ->
    gen_server:call(Pid, {put, Key, Value}).

init([Capacity]) ->
    {ok, #state{capacity = Capacity}}.

handle_call({get, Key}, _From, State = #state{map = Map, list = List}) ->
    case maps:find(Key, Map) of
        {ok, Value} ->
            NewList = [Key | lists:delete(Key, List)],
            {reply, Value, State#state{list = NewList}};
        error ->
            {reply, -1, State}
    end;

handle_call({put, Key, Value}, _From, State = #state{capacity = Capacity, size = Size, map = Map, list = List}) ->
    case maps:find(Key, Map) of
        {ok, _} ->
            NewMap = maps:put(Key, Value, Map),
            NewList = [Key | lists:delete(Key, List)],
            {reply, ok, State#state{map = NewMap, list = NewList}};
        error when Size < Capacity ->
            NewMap = maps:put(Key, Value, Map),
            NewList = [Key | List],
            {reply, ok, State#state{map = NewMap, list = NewList, size = Size + 1}};
        error ->
            [LRUKey | RestList] = lists:reverse(List),
            NewMap = maps:put(Key, Value, maps:remove(LRUKey, Map)),
            NewList = [Key | lists:delete(LRUKey, List)],
            {reply, ok, State#state{map = NewMap, list = NewList}}
    end;

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.