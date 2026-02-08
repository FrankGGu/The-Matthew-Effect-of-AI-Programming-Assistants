-module(parking_system).
-export([start/1, add_car/2]).

-record(state, {big, medium, small}).

start(Big, Medium, Small) ->
    {ok, #state{big = Big, medium = Medium, small = Small}}.

add_car(1, State) ->
    case State#state.big > 0 of
        true ->
            NewState = State#state{big = State#state.big - 1},
            {true, NewState};
        false ->
            {false, State}
    end;
add_car(2, State) ->
    case State#state.medium > 0 of
        true ->
            NewState = State#state{medium = State#state.medium - 1},
            {true, NewState};
        false ->
            {false, State}
    end;
add_car(3, State) ->
    case State#state.small > 0 of
        true ->
            NewState = State#state{small = State#state.small - 1},
            {true, NewState};
        false ->
            {false, State}
    end.