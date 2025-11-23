-module(solution).
-export([number_of_ways/1]).

number_of_ways(Corridor) ->
    PlantIndices = get_plant_indices(Corridor),
    N = length(PlantIndices),

    if
        N == 0 orelse N rem 2 == 1 ->
            0;
        true ->
            calculate_ways(PlantIndices)
    end.

get_plant_indices(Corridor) ->
    CorridorList = string:to_list(Corridor),
    get_plant_indices_recursive(CorridorList, 0, []).

get_plant_indices_recursive([], _Idx, Acc) ->
    lists:reverse(Acc);
get_plant_indices_recursive([$S | T], Idx, Acc) ->
    get_plant_indices_recursive(T, Idx + 1, [Idx | Acc]);
get_plant_indices_recursive([_ | T], Idx, Acc) ->
    get_plant_indices_recursive(T, Idx + 1, Acc).

calculate_ways(PlantIndices) ->
    Mod = 1000000007,

    % State for lists:foldl: {AccWays, CurrentPlantIndex, PrevPlantPos}
    % AccWays: The accumulated product of ways.
    % CurrentPlantIndex: The 0-based index of the plant *just processed* in the fold.
    % PrevPlantPos: The position of the plant *just processed*.
    % Initial state:
    %   AccWays = 1 (multiplicative identity)
    %   CurrentPlantIndex = -1 (before processing the first plant at index 0)
    %   PrevPlantPos = -1 (dummy value, as it's not used for the first plant)

    {FinalWays, _FinalPlantIndex, _FinalPrevPlantPos} =
        lists:foldl(
            fun(CurrentPlantPos, {AccWays, CurrentPlantIndex, PrevPlantPos}) ->
                NewPlantIndex = CurrentPlantIndex + 1,
                NewAccWays = 
                    if
                        % We need to multiply (P_k - P_{k-1}) when k is 2, 4, 6, ..., N-2.
                        % In 0-based indexing, this means when NewPlantIndex is 2, 4, ..., N-2.
                        NewPlantIndex rem 2 == 0 andalso NewPlantIndex > 0 ->
                            (AccWays * (CurrentPlantPos - PrevPlantPos)) rem Mod;
                        true ->
                            AccWays
                    end,
                {NewAccWays, NewPlantIndex, CurrentPlantPos}
            end,
            {1, -1, -1}, % Initial state
            PlantIndices
        ),
    FinalWays.