-module(cinema_seat_allocation).
-export([max_number_of_families/2]).

max_number_of_families(N, ReservedSeats) ->
    Seats = lists:foldl(fun({Row, Col}, Acc) ->
                                maps:update_with(Row, fun(List) -> [Col | List] end, [Col], Acc)
                        end, #{}, ReservedSeats),
    lists:foldl(fun({Row, Reserved}, Count) ->
                        case true of
                            (not lists:member(2, Reserved)) and (not lists:member(3, Reserved)) and (not lists:member(4, Reserved)) and (not lists:member(5, Reserved)) ->
                                case true of
                                    (not lists:member(6, Reserved)) and (not lists:member(7, Reserved)) and (not lists:member(8, Reserved)) and (not lists:member(9, Reserved)) ->
                                        Count + 2;
                                    true ->
                                        Count + 1
                                end;
                            (not lists:member(6, Reserved)) and (not lists:member(7, Reserved)) and (not lists:member(8, Reserved)) and (not lists:member(9, Reserved)) ->
                                Count + 1;
                            (not lists:member(4, Reserved)) and (not lists:member(5, Reserved)) and (not lists:member(6, Reserved)) and (not lists:member(7, Reserved)) ->
                                Count + 1;
                            true ->
                                Count
                        end
                end, N * 2, maps:to_list(Seats)).