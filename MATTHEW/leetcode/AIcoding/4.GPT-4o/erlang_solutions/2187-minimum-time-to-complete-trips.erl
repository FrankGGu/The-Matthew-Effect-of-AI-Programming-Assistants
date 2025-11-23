-module(solution).
-export([minimum_time/2]).

minimum_time(vehicles, time_limit) ->
    low = 1,
    high = lists:max(vehicles) * time_limit,
    binary_search(vehicles, low, high).

binary_search(Vehicles, Low, High) ->
    case Low >= High of
        true -> Low;
        false ->
            Mid = (Low + High) div 2,
            TotalTrips = lists:foldl(fun(Vehicle, Acc) ->
                Acc + Mid div Vehicle
            end, 0, Vehicles),
            case TotalTrips >= time_limit of
                true -> binary_search(Vehicles, Low, Mid);
                false -> binary_search(Vehicles, Mid + 1, High)
            end
    end.