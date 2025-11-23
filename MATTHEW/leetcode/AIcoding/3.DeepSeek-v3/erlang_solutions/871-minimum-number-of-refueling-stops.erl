-spec min_refuel_stops(Target :: integer(), StartFuel :: integer(), Stations :: [[integer()]]) -> integer().
min_refuel_stops(Target, StartFuel, Stations) ->
    PriorityQueue = [],
    solve(Target, StartFuel, Stations, PriorityQueue, 0).

solve(Target, Fuel, [], PQ, Stops) ->
    case Fuel >= Target of
        true -> Stops;
        false ->
            case PQ of
                [] -> -1;
                _ ->
                    {MaxFuel, NewPQ} = get_max(PQ),
                    solve(Target, Fuel + MaxFuel, [], NewPQ, Stops + 1)
            end;
    end;
solve(Target, Fuel, [[Pos, Gas] | Rest], PQ, Stops) ->
    if
        Fuel >= Pos ->
            NewPQ = insert(PQ, Gas),
            solve(Target, Fuel, Rest, NewPQ, Stops);
        true ->
            case PQ of
                [] -> -1;
                _ ->
                    {MaxFuel, NewPQ} = get_max(PQ),
                    solve(Target, Fuel + MaxFuel, [[Pos, Gas] | Rest], NewPQ, Stops + 1)
            end
    end.

insert(PQ, Gas) ->
    heap:insert(Gas, PQ).

get_max(PQ) ->
    heap:extract_max(PQ).