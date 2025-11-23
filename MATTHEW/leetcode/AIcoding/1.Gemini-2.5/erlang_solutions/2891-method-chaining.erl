-module(chain_builder).
-export([new/0, add/2, multiply/2, get_value/1]).

-record(builder_state, {value = 0}).

new() ->
    #builder_state{value = 0}.

add(State, N) ->
    State#builder_state{value = State#builder_state.value + N}.

multiply(State, N) ->
    State#builder_state{value = State#builder_state.value * N}.

get_value(State) ->
    State#builder_state.value.