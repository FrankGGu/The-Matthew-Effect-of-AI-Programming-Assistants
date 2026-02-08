-module(watering_plants_ii).
-export([watering_plants_ii/1]).

watering_plants_ii(Args) ->
    plants(lists:nth(1, Args), lists:nth(2, Args), lists:nth(3, Args), 0, lists:nth(4, Args), lists:nth(2, Args), 0).

plants([], _, _, Steps, _, _, _) ->
    Steps;
plants(Plants, CapacityA, CapacityB, Steps, WaterA, WaterB, I) ->
    case I rem 2 of
        0 ->
            case lists:nth(1, Plants) =< WaterA of
                true ->
                    plants(tl(Plants), CapacityA, CapacityB, Steps, WaterA - lists:nth(1, Plants), WaterB, I + 1);
                false ->
                    plants(tl(Plants), CapacityA, CapacityB, Steps + 1, CapacityA - lists:nth(1, Plants), WaterB, I + 1)
            end;
        1 ->
            case lists:nth(1, Plants) =< WaterB of
                true ->
                    plants(tl(Plants), CapacityA, CapacityB, Steps, WaterA, WaterB - lists:nth(1, Plants), I + 1);
                false ->
                    plants(tl(Plants), CapacityA, CapacityB, Steps + 1, WaterA, CapacityB - lists:nth(1, Plants), I + 1)
            end
    end.