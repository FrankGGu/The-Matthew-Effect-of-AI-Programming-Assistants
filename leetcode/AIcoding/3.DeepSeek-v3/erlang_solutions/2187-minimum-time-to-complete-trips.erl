-spec minimum_time(Time :: [integer()], TotalTrips :: integer()) -> integer().
minimum_time(Time, TotalTrips) ->
    Left = 1,
    Right = lists:min(Time) * TotalTrips,
    binary_search(Time, TotalTrips, Left, Right).

binary_search(Time, TotalTrips, Left, Right) when Left < Right ->
    Mid = Left + (Right - Left) div 2,
    case can_complete(Time, TotalTrips, Mid) of
        true -> binary_search(Time, TotalTrips, Left, Mid);
        false -> binary_search(Time, TotalTrips, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) -> Left.

can_complete(Time, TotalTrips, Mid) ->
    Trips = lists:foldl(fun(T, Acc) -> Acc + Mid div T end, 0, Time),
    Trips >= TotalTrips.