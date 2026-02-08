-module(exam_room).
-export([init/1, seat/1, leave/2]).

-record(state, {seats = []}).

init(_N) ->
    #state{}.

seat(State) ->
    Seats = State#state.seats,
    case Seats of
        [] ->
            {0, State#state{seats = [0]}};
        _ ->
            MaxDist = -1,
            Position = 0,
            {NewPosition, NewMaxDist} = find_seat(Seats, MaxDist, Position),
            {NewPosition, State#state{seats = lists:sort([NewPosition | Seats])}}
    end.

leave(State, P) ->
    Seats = State#state.seats,
    NewSeats = lists:delete(P, Seats),
    State#state{seats = NewSeats}.

find_seat([], MaxDist, Position) ->
    {Position, MaxDist};
find_seat([H | T], MaxDist, Position) ->
    case T of
        [] ->
            Dist = H,
            if Dist > MaxDist ->
                find_seat(T, Dist, 0);
            true ->
                find_seat(T, MaxDist, Position)
            end;
        [Next | _] ->
            Dist = (Next - H) div 2,
            if Dist > MaxDist ->
                find_seat(T, Dist, H + Dist);
            true ->
                find_seat(T, MaxDist, Position)
            end
    end.