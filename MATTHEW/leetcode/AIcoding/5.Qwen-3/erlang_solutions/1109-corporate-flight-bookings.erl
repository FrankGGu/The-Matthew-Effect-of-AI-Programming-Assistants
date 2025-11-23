-module(solution).
-export([find_corporate_flight_bookings/2]).

find_corporate_flight_bookings(Booking, N) ->
    List = lists:duplicate(N, 0),
    lists:foldl(fun({Start, End, Seats}, Acc) ->
        update(Acc, Start, End, Seats)
    end, List, Booking).

update(List, Start, End, Seats) ->
    update(List, Start - 1, End - 1, Seats, []).

update([], _, _, _, Acc) ->
    lists:reverse(Acc);
update([H | T], Start, End, Seats, Acc) ->
    if
        Start == 0 ->
            NewH = H + Seats,
            update(T, Start - 1, End - 1, Seats, [NewH | Acc]);
        Start > 0 ->
            update(T, Start - 1, End - 1, Seats, [H | Acc])
    end.