-module(ExamRoom).
-export([new/1, seat/1, leave/2]).

-record(state, {n, seats = []}).

new(N) ->
    #state{n = N}.

seat(Room) ->
    Seats = Room#state.seats,
    N = Room#state.n,
    Seat = seat_helper(Seats, N),
    NewSeats = lists:sort([Seat | Seats]),
    {Seat, Room#state{seats = NewSeats}}.

leave(Room, p) ->
    Seats = Room#state.seats,
    NewSeats = lists:delete(p, Seats),
    Room#state{seats = NewSeats}.

seat_helper([], _) -> 0;
seat_helper(Seats, N) ->
    MaxDist = lists:foldl(fun (x, {prev, max_dist}) ->
        Dist = (x - prev) div 2,
        {x, max(max_dist, Dist)}
    end, {0, 0}, Seats),
    DistFromEnd = N - lists:last(Seats) - 1,
    max(fst(MaxDist), DistFromEnd).

fst({X, _}) -> X.