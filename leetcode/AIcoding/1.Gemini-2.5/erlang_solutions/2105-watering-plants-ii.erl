-module(Solution).
-export([watering_plants_ii/3]).

watering_plants_ii(Plants, CapacityA, CapacityB) ->
    N = length(Plants),
    % Convert the list of plants to a tuple for O(1) element access.
    TuplePlants = list_to_tuple(Plants),
    solve(TuplePlants, 0, N - 1, CapacityA, CapacityB, CapacityA, CapacityB, 0).

solve(TuplePlants, Left, Right, CurrentWaterA, CurrentWaterB, CapacityA, CapacityB, Refills) when Left > Right ->
    Refills;

solve(TuplePlants, Left, Right, CurrentWaterA, CurrentWaterB, CapacityA, CapacityB, Refills) when Left == Right ->
    % This is the meeting point.
    Plant = element(Left + 1, TuplePlants), % Get plant requirement (1-indexed for tuple)

    % Determine if Alice needs to refill
    RefillsA = if CurrentWaterA < Plant -> 1; true -> 0 end,

    % Determine if Bob needs to refill
    RefillsB = if CurrentWaterB < Plant -> 1; true -> 0 end,

    % Total refills for this plant (Alice's potential refill + Bob's potential refill)
    Refills + RefillsA + RefillsB;

solve(TuplePlants, Left, Right, CurrentWaterA, CurrentWaterB, CapacityA, CapacityB, Refills) when Left < Right ->
    % Alice waters plant at 'Left'
    PlantA = element(Left + 1, TuplePlants), % Get plant requirement for Alice
    RefillsA = if CurrentWaterA < PlantA -> 1; true -> 0 end,
    WaterA_AfterRefill = if CurrentWaterA < PlantA -> CapacityA; true -> CurrentWaterA end,
    WaterA_AfterWater = WaterA_AfterRefill - PlantA,

    % Bob waters plant at 'Right'
    PlantB = element(Right + 1, TuplePlants), % Get plant requirement for Bob
    RefillsB = if CurrentWaterB < PlantB -> 1; true -> 0 end,
    WaterB_AfterRefill = if CurrentWaterB < PlantB -> CapacityB; true -> CurrentWaterB end,
    WaterB_AfterWater = WaterB_AfterRefill - PlantB,

    % Recurse for the next pair of plants
    solve(TuplePlants, Left + 1, Right - 1, WaterA_AfterWater, WaterB_AfterWater, CapacityA, CapacityB, Refills + RefillsA + RefillsB).