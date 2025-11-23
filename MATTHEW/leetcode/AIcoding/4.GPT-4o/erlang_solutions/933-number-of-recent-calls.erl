-module(RecentCounter).
-export([new/0, ping/1]).

-record(state, {calls = []}).

new() ->
    #state{}.

ping(T) ->
    State = self(),
    Calls = State#state.calls,
    NewCalls = lists:filter(fun(X) -> X >= T - 3000 end, Calls ++ [T]),
    State#state{calls = NewCalls}.