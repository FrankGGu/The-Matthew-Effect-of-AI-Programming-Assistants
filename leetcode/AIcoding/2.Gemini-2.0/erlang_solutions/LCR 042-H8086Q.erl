-module(recent_counter).
-export([new/0, ping/1]).

-record(state, {requests = []}).

new() ->
  #state{requests = []}.

ping(Timestamp) ->
  ping(Timestamp, new()).

ping(Timestamp, State) ->
  Requests = State#state.requests,
  NewRequests = [T || T <- Requests, T >= Timestamp - 3000],
  NewRequests2 = NewRequests ++ [Timestamp],
  NewState = State#state{requests = NewRequests2},
  length(NewRequests2).