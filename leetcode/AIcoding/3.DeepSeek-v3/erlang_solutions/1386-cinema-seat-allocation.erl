-module(solution).
-export([max_number_of_families/2]).

max_number_of_families(N, ReservedSeats) ->
    Reserved = lists:foldl(fun([Row, Col], Acc) ->
                                  case Acc of
                                      #{Row := Seats} -> Acc#{Row := [Col | Seats]};
                                      _ -> Acc#{Row => [Col]}
                                  end
                          end, #{}, ReservedSeats),
    lists:foldl(fun(Row, Sum) ->
                        case maps:get(Row, Reserved, []) of
                            [] -> Sum + 2;
                            Seats -> 
                                ReservedSet = sets:from_list(Seats),
                                Left = not (sets:is_element(2, ReservedSet) orelse
                                            sets:is_element(3, ReservedSet) orelse
                                            sets:is_element(4, ReservedSet) orelse
                                            sets:is_element(5, ReservedSet),
                                Middle = not (sets:is_element(6, ReservedSet) orelse
                                            sets:is_element(7, ReservedSet) orelse
                                            sets:is_element(8, ReservedSet) orelse
                                            sets:is_element(9, ReservedSet),
                                Right = not (sets:is_element(4, ReservedSet) orelse
                                            sets:is_element(5, ReservedSet) orelse
                                            sets:is_element(6, ReservedSet) orelse
                                            sets:is_element(7, ReservedSet),
                                case {Left, Middle, Right} of
                                    {false, false, false} -> Sum;
                                    {_, false, _} -> Sum + 1;
                                    {false, _, false} -> Sum + 1;
                                    {true, _, true} -> Sum + 2;
                                    _ -> Sum + 1
                                end
                        end
                end, 0, lists:seq(1, N)).