-module(seat_reservation_manager).
-export([new/1, reserve/1, unreserve/2]).

-record(state, {next_seat = 1, reserved = gb_sets:new()}).

new(N) ->
    #state{next_seat = N + 1}.

reserve(S) ->
    State = S#state{reserved = gb_sets:remove(0, S#state.reserved)},
    case gb_sets:is_empty(State#state.reserved) of
        true ->
            Seat = State#state.next_seat,
            NewState = State#state{next_seat = Seat + 1},
            {Seat, NewState};
        false ->
            Min = gb_sets:smallest(State#state.reserved),
            NewReserved = gb_sets:remove(Min, State#state.reserved),
            {Min, State#state{reserved = NewReserved}}
    end.

unreserve(S, Seat) ->
    State = S#state{reserved = gb_sets:add(Seat, S#state.reserved)},
    case Seat < State#state.next_seat of
        true ->
            State;
        false ->
            State#state{next_seat = Seat}
    end.