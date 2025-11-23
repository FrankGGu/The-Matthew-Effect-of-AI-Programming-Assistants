-module(solution).
-export([max_bookings/1]).

max_bookings(Seats) ->
    lists:foldl(fun(Seat, Acc) -> 
        case Seat of
            [A,B,C,D,E,F] -> 
                case is_available(A,B,C,D,E,F) of
                    true -> Acc + 1;
                    false -> Acc
                end;
            _ -> Acc
        end
    end, 0, Seats).

is_available(A,B,C,D,E,F) ->
    (B == 0 andalso D == 0 andalso F == 0) orelse
    (A == 0 andalso C == 0 andalso E == 0) orelse
    (B == 0 andalso C == 0 andalso D == 0) orelse
    (C == 0 andalso D == 0 andalso E == 0).