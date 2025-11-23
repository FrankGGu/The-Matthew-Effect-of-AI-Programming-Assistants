-module(solution).
-export([watering_plants/3]).

watering_plants(plant, capacity_a, capacity_b) ->
    watering(plant, capacity_a, capacity_b, 0, 0, 0).

watering([], _, _, Days, _, _) -> 
    Days;
watering(Plants, CapacityA, CapacityB, Days, WaterA, WaterB) ->
    case Plants of
        [H | T] ->
            case WaterA >= H of
                true -> 
                    watering(T, CapacityA, CapacityB, Days + 1, WaterA - H, WaterB);
                false -> 
                    case WaterB >= H of
                        true -> 
                            watering(T, CapacityA, CapacityB, Days + 1, WaterA, WaterB - H);
                        false ->
                            NewDays = Days + 1 + (if WaterA > 0 -> 1; true -> 0 end) + (if WaterB > 0 -> 1; true -> 0 end),
                            watering(T, CapacityA, CapacityB, NewDays, CapacityA - H, CapacityB)
                    end
            end;
        [] -> 
            Days
    end.