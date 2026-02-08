-module(solution).
-export([watering_plants/2]).

watering_plants(Plants, Capacity) ->
    % Initial call:
    % Plants: list of plant water needs
    % OriginalCapacity: max capacity of watering can
    % CurrentWater: water currently in can (starts full)
    % CurrentPlantIndex: index of plant to water (starts at 0)
    % LastWateredPlantIndex: position of the last plant watered, or -1 if at river
    % TotalSteps: total steps taken so far
    solve(Plants, Capacity, Capacity, 0, -1, 0).

solve([], _OriginalCapacity, _CurrentWater, _CurrentPlantIndex, _LastWateredPlantIndex, TotalSteps) ->
    % Base case: All plants watered, return total steps
    TotalSteps;
solve([PlantWaterNeeded | RestOfPlants], OriginalCapacity, CurrentWater, CurrentPlantIndex, LastWateredPlantIndex, TotalSteps) ->
    if CurrentWater >= PlantWaterNeeded ->
        % Enough water, move to this plant and water it
        % Steps taken are from the last watered plant's position (or river) to the current plant's position
        StepsToPlant = CurrentPlantIndex - LastWateredPlantIndex,
        NewTotalSteps = TotalSteps + StepsToPlant,
        NewWater = CurrentWater - PlantWaterNeeded,
        NewLastWateredPlantIndex = CurrentPlantIndex, % Update position to current plant
        solve(RestOfPlants, OriginalCapacity, NewWater, CurrentPlantIndex + 1, NewLastWateredPlantIndex, NewTotalSteps);
    else ->
        % Not enough water. Must go back to the river, refill, and then come to the current plant.
        % We are currently at LastWateredPlantIndex.
        % 1. Steps to go from LastWateredPlantIndex back to river (-1)
        StepsToRiver = LastWateredPlantIndex - (-1), % Equivalent to LastWateredPlantIndex + 1

        % 2. Refill (CurrentWater becomes OriginalCapacity)
        % 3. Steps to go from river (-1) back to CurrentPlantIndex
        StepsFromRiverToPlant = CurrentPlantIndex - (-1), % Equivalent to CurrentPlantIndex + 1

        % Total steps for this refill trip
        RefillTripSteps = StepsToRiver + StepsFromRiverToPlant,
        NewTotalSteps = TotalSteps + RefillTripSteps,

        NewWater = OriginalCapacity - PlantWaterNeeded, % Water the plant after refilling
        NewLastWateredPlantIndex = CurrentPlantIndex, % Update position to current plant
        solve(RestOfPlants, OriginalCapacity, NewWater, CurrentPlantIndex + 1, NewLastWateredPlantIndex, NewTotalSteps)
    end.