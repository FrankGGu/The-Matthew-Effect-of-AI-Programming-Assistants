-module(solution).
-export([corpFlightBookings/3]).

corpFlightBookings(Bookings, N) ->
    Arrivals = lists:foldl(fun({Start, End, Seats}, Acc) ->
        Acc1 = lists:duplicate(Start - 1, 0) ++ Acc,
        Acc2 = lists:duplicate(End, 0) ++ Acc1,
        lists:zip_with(fun(X, Y) -> X + Y end, Acc2, lists:duplicate(End - Start + 1, Seats))
    end, lists:duplicate(N, 0), Bookings),
    lists:map(fun(X) -> lists:sum(lists:sublist(Arrivals, 1, X)) end, lists:seq(1, N)).