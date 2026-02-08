-module(MethodChaining).
-export([new/0, add/2, multiply/2, get_result/1]).

-record(state, {value = 0}).

new() ->
    #state{}.

add(State, X) ->
    NewValue = State#state.value + X,
    #state{value = NewValue}.

multiply(State, X) ->
    NewValue = State#state.value * X,
    #state{value = NewValue}.

get_result(State) ->
    State#state.value.