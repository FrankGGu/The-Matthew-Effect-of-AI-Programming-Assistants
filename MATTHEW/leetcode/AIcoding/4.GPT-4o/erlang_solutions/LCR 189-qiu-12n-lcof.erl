-module(MechanicalAccumulator).
-export([new/0, add/2, get/1]).

-record(state, {sum = 0}).

new() ->
    #state{}.

add(State, x) ->
    NewSum = State#state.sum + x,
    State#state{sum = NewSum}.

get(State) ->
    State#state.sum.