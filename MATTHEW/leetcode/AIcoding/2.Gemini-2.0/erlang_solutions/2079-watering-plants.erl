-module(watering_plants).
-export([watering_plants/1]).

watering_plants(Plants) ->
    watering_plants(Plants, length(Plants), length(Plants), 0).

watering_plants([], _, _, Steps) ->
    Steps;
watering_plants([Plant | Rest], Capacity, Current, Steps) ->
    case Plant =< Current of
        true ->
            watering_plants(Rest, Capacity, Current - Plant, Steps + 1);
        false ->
            watering_plants(Rest, Capacity, Capacity - Plant, Steps + length(Rest) + 1 + length(Rest) + 1)
    end.