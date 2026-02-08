-module(solution).
-export([number_of_people_in_range/2]).

number_of_people_in_range(Arrival, Duration) ->
    lists:foldl(fun({A, D}, Acc) ->
                        case is_in_range(A, D, Arrival, Duration) of
                            true ->
                                Acc + 1;
                            false ->
                                Acc
                        end
                end, 0, Arrival).

is_in_range(A, D, Arrival, Duration) ->
    End = A + D,
    ArrivalEnd = Arrival + Duration,
    case (A >= Arrival and A < ArrivalEnd) orelse (End > Arrival and End <= ArrivalEnd) orelse (A <= Arrival and End >= ArrivalEnd) of
        true ->
            true;
        false ->
            false
    end.