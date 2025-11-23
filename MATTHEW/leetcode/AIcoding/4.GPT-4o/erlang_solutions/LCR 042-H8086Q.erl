-module(RequestCounter).
-export([new/0, ping/2, recent_requests/2]).

-record(state, {timestamps = []}).

new() ->
    #state{}.

ping(State, T) ->
    NewTimestamps = lists:filter(fun(X) -> X >= T - 3000 end, State#state.timestamps),
    NewState = State#state{timestamps = [T | NewTimestamps]},
    {NewState, length(NewState#state.timestamps)}.

recent_requests(State, T) ->
    RecentTimestamps = lists:filter(fun(X) -> X >= T - 3000 end, State#state.timestamps),
    length(RecentTimestamps).