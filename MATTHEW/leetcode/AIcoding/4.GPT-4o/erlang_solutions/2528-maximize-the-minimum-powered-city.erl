-module(solution).
-export([maximize_min_powered_city/2]).

maximize_min_powered_city(Cities, Power) ->
    MaxPower = lists:max(Cities),
    MinPower = 1,
    MaxPower =:= MinPower andalso MaxPower;
    binary_search(MinPower, MaxPower, Cities, Power).

binary_search(Low, High, Cities, Power) ->
    case Low =< High of
        true ->
            Mid = (Low + High) div 2,
            if
                can_power_cities(Mid, Cities, Power) ->
                    binary_search(Mid + 1, High, Cities, Power);
                true ->
                    binary_search(Low, Mid - 1, Cities, Power)
            end;
        false ->
            High
    end.

can_power_cities(MinPower, Cities, Power) ->
    lists:foldl(fun(City, {TotalPower, UsedPower}) ->
        if
            City >= MinPower ->
                {TotalPower + City, UsedPower};
            true ->
                {TotalPower, UsedPower + City}
        end
    end, {0, 0}, Cities) =< Power.