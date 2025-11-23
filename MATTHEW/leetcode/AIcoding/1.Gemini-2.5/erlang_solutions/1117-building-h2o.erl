-module(h2o).
-behaviour(gen_server).

-export([start_link/0, hydrogen/1, oxygen/1]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

hydrogen(ReleaseHydrogen) ->
    gen_server:call(?MODULE, h_ready),
    ReleaseHydrogen().

oxygen(ReleaseOxygen) ->
    gen_server:call(?MODULE, o_ready),
    ReleaseOxygen().

init([]) ->
    {ok, {0, 0, [], []}}.

handle_call(h_ready, From, {HCount, OCount, WaitingHFroms, WaitingOFroms}) ->
    NewHCount = HCount + 1,
    NewWaitingHFroms = [From | WaitingHFroms],
    CurrentState = {NewHCount, OCount, NewWaitingHFroms, WaitingOFroms},

    NewState = maybe_release(CurrentState),

    {noreply, NewState}.

handle_call(o_ready, From, {HCount, OCount, WaitingHFroms, WaitingOFroms}) ->
    NewOCount = OCount + 1,
    NewWaitingOFroms = [From | WaitingOFroms],
    CurrentState = {HCount, NewOCount, WaitingHFroms, NewWaitingOFroms},

    NewState = maybe_release(CurrentState),

    {noreply, NewState}.

maybe_release({HCount, OCount, WaitingHFroms, WaitingOFroms} = State) ->
    if
        HCount >= 2 andalso OCount >= 1 ->
            [HFrom1, HFrom2 | RemainingHFroms] = WaitingHFroms,
            [OFrom | RemainingOFroms] = WaitingOFroms,

            gen_server:reply(HFrom1, ok),
            gen_server:reply(HFrom2, ok),
            gen_server:reply(OFrom, ok),

            NewHCount = HCount - 2,
            NewOCount = OCount - 1,
            {NewHCount, NewOCount, RemainingHFroms, RemainingOFroms};
        true ->
            State
    end.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.