-module(watering_plants).
-export([water_plants/1]).

water_plants(Plants) ->
    water_plants(Plants, 0, 0).

water_plants([], _Capacity, _Steps) ->
    _Steps;
water_plants([H | T], Capacity, Steps) ->
    if
        H =< Capacity ->
            water_plants(T, Capacity - H, Steps + 1);
        true ->
            water_plants([H | T], Capacity, Steps + length([H | T]) * 2)
    end.