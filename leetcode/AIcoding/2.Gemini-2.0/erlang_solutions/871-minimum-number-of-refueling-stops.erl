-module(minimum_refueling_stops).
-export([min_refuel_stops/3]).

min_refuel_stops(Target, StartFuel, Stations) ->
    min_refuel_stops(Target, StartFuel, Stations, 0).

min_refuel_stops(Target, Fuel, [], Stops) ->
    case Fuel >= Target of
        true -> Stops;
        false -> -1
    end;
min_refuel_stops(Target, Fuel, Stations, Stops) ->
    min_refuel_stops_helper(Target, Fuel, Stations, Stops, []).

min_refuel_stops_helper(Target, Fuel, [], Stops, Pq) ->
    case Fuel >= Target of
        true -> Stops;
        false ->
            case Pq of
                [] -> -1;
                _ ->
                    {MaxFuel, NewPq} = lists:max(Pq),
                    min_refuel_stops(Target, Fuel + MaxFuel, [], Stops + 1)
            end
    end;
min_refuel_stops_helper(Target, Fuel, [{Location, Capacity} | Rest], Stops, Pq) ->
    case Fuel >= Location of
        true ->
            NewPq = lists:sort(fun(A, B) -> A > B end, [Capacity | Pq]),
            min_refuel_stops_helper(Target, Fuel, Rest, Stops, NewPq);
        false ->
            case Pq of
                [] -> -1;
                _ ->
                    {MaxFuel, NewPq} = lists:max(Pq),
                    NewStops = Stops + 1,
                    NewFuel = Fuel + MaxFuel,
                    case NewFuel >= Location of
                        true ->
                            min_refuel_stops_helper(Target, NewFuel, [{Location, Capacity} | Rest], NewStops, NewPq -- [MaxFuel]);
                        false ->
                            case NewPq -- [MaxFuel] of
                                [] -> -1;
                                _ ->
                                    {MaxFuel2, NewPq2} = lists:max(NewPq -- [MaxFuel]),
                                    NewStops2 = NewStops + 1,
                                    NewFuel2 = NewFuel + MaxFuel2,
                                    min_refuel_stops_helper(Target, NewFuel2, [{Location, Capacity} | Rest], NewStops2, NewPq -- [MaxFuel] -- [MaxFuel2])
                            end
                    end
            end
    end.