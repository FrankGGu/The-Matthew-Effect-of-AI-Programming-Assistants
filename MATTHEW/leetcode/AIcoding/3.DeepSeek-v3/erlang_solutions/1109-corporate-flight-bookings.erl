-spec corp_flight_bookings(Bookings :: [[integer()]], N :: integer()) -> [integer()].
corp_flight_bookings(Bookings, N) ->
    Diffs = lists:foldl(fun([First, Last, Seats], Acc) ->
                            update_diff(First, Last, Seats, Acc)
                        end, array:new(N, {default, 0}), Bookings),
    compute_result(Diffs, N).

update_diff(First, Last, Seats, Diffs) ->
    D1 = case First =< array:size(Diffs) of
             true -> array:set(First - 1, array:get(First - 1, Diffs) + Seats, Diffs;
             false -> Diffs
         end,
    case Last < array:size(Diffs) of
        true -> array:set(Last, array:get(Last, D1) - Seats, D1);
        false -> D1
    end.

compute_result(Diffs, N) ->
    compute_result(0, 0, Diffs, N, []).

compute_result(Index, Current, Diffs, N, Acc) when Index < N ->
    Seats = array:get(Index, Diffs),
    NewCurrent = Current + Seats,
    compute_result(Index + 1, NewCurrent, Diffs, N, [NewCurrent | Acc]);
compute_result(_, _, _, _, Acc) ->
    lists:reverse(Acc).