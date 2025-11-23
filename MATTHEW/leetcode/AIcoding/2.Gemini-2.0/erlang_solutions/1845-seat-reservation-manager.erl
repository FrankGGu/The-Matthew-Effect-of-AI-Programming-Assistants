-module(seat_manager).
-export([new/1, reserve/1, unreserve/2]).

-record(state, {available_seats = gb_sets:empty()}).

new(N) ->
    AvailableSeats = lists:seq(1, N),
    State = #state{available_seats = gb_sets:from_list(AvailableSeats)},
    {ok, State}.

reserve({ok, State = #state{available_seats = AvailableSeats}}) ->
    case gb_sets:is_empty(AvailableSeats) of
        true ->
            {error, no_seats};
        false ->
            {Seat, NewAvailableSeats} = gb_sets:take_smallest(AvailableSeats),
            NewState = State#state{available_seats = NewAvailableSeats},
            {Seat, {ok, NewState}}
    end.

unreserve(Seat, {ok, State = #state{available_seats = AvailableSeats}}) ->
    NewAvailableSeats = gb_sets:add(Seat, AvailableSeats),
    NewState = State#state{available_seats = NewAvailableSeats},
    {ok, NewState}.