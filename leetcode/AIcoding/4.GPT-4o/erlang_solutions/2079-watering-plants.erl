-module(solution).
-export([watering_plants/2]).

watering_plants(Plants, Capacity) ->
    watering(Plants, Capacity, 0, 0, 0).

watering([], _, TotalSteps, _, TotalSteps) -> TotalSteps;
watering([H | T], Capacity, CurrentWater, TotalSteps, Acc) ->
    case CurrentWater >= H of
        true ->
            watering(T, Capacity, CurrentWater - H, TotalSteps + 1, Acc);
        false ->
            NewWater = Capacity,
            Steps = (TotalSteps + 2 * (Acc + 1)) + 1,
            watering(T, Capacity, NewWater - H, Steps, Acc + 1)
    end.