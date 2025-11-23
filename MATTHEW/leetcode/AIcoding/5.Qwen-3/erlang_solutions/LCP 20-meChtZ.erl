-module(bus_rapid_transit).
-export([num_buses_to_dest/2]).

num_buses_to_dest(1, 1) -> 0;
num_buses_to_dest(Dest, Routes) ->
    Buses = lists:foldl(fun(Route, Acc) ->
        case lists:member(Dest, Route) of
            true -> [Route | Acc];
            false -> Acc
        end
    end, [], Routes),
    if
        Buses == [] -> -1;
        true -> length(Buses)
    end.