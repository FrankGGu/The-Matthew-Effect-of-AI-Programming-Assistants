-module(solution).
-export([maximizeTheMinimumPoweredCity/3]).

maximizeTheMinimumPoweredCity(Stations, R, K) ->
    N = length(Stations),
    StationsArray = array:from_list(Stations),

    % Calculate initial sum of existing station powers for the upper bound of binary search
    SumStations = lists:sum(Stations),

    % Binary search range for the minimum power
    Low = 0,
    High = SumStations + K, % Max possible power for any city is sum of all stations + K added power

    binary_search(Low, High, StationsArray, N, R, K).

binary_search(Low, High, StationsArray, N, R, K) ->
    if
        Low > High ->
            High; % High will be the last valid minimum power found
        true ->
            Mid = Low + (High - Low) div 2,
            if
                check(StationsArray, N, R, K, Mid) ->
                    binary_search(Mid + 1, High, StationsArray, N, R, K);
                true ->
                    binary_search(Low, Mid - 1, StationsArray, N, R, K)
            end
    end.

check(StationsArray, N, R, K, TargetMinPower) ->
    % Step 1: Calculate initial power for each city from existing stations
    DiffInitial = array:new(N, {default, 0}),

    % Populate DiffInitial using difference array technique
    % Each station at index I contributes to cities [max(0, I-R), min(N-1, I+R)]
    DiffInitial1 = lists:foldl(fun(I, CurrentDiff) ->
        StationVal = array:get(I, StationsArray),
        if
            StationVal > 0 ->
                Start = max(0, I - R),
                End = min(N - 1, I + R),

                NewDiffA = array:set(Start, array:get(Start, CurrentDiff) + StationVal, CurrentDiff),
                if
                    End + 1 < N ->
                        array:set(End + 1, array:get(End + 1, NewDiffA) - StationVal, NewDiffA);
                    true ->
                        NewDiffA
                end;
            true ->
                CurrentDiff
        end
    end, DiffInitial, lists:seq(0, N - 1)),

    % Convert DiffInitial1 to CurrentPower array (power from existing stations)
    CurrentPowerArray = array:new(N, {default, 0}),
    {FinalCurrentPowerArray, _} = lists:foldl(fun(I, {AccPowerArray, AccSum}) ->
        NewSum = AccSum + array:get(I, DiffInitial1),
        {array:set(I, NewSum, AccPowerArray), NewSum}
    end, {CurrentPowerArray, 0}, lists:seq(0, N - 1)),

    % Step 2: Greedily add K stations if needed to meet TargetMinPower
    % Use a tail-recursive helper function to manage state efficiently
    check_loop(0, N, R, K, TargetMinPower, FinalCurrentPowerArray, 0, array:new(N, {default, 0}), 0).

check_loop(I, N, R, K, TargetMinPower, InitialPowerArray, AddedStationsCount, AddedPowerDiff, CurrentAddedPower) ->
    if
        I >= N ->
            true; % All cities checked, possible
        true ->
            % Update CurrentAddedPower by adding contributions from stations that started affecting city I
            NewCurrentAddedPower = CurrentAddedPower + array:get(I, AddedPowerDiff),
            TotalPowerAtI = array:get(I, InitialPowerArray) + NewCurrentAddedPower,

            if
                TotalPowerAtI < TargetMinPower ->
                    Needed = TargetMinPower - TotalPowerAtI,
                    NewAddedStationsCount = AddedStationsCount + Needed,
                    if
                        NewAddedStationsCount > K ->
                            false; % Exceeded K stations
                        true ->
                            % Place a new station at the rightmost possible position to cover city I
                            PlacementIdx = min(N - 1, I + R),

                            % Update AddedPowerDiff for the new station
                            NewAddedPowerDiff1 = array:set(PlacementIdx, array:get(PlacementIdx, AddedPowerDiff) + Needed, AddedPowerDiff),
                            NewAddedPowerDiff = if
                                PlacementIdx + R + 1 < N ->
                                    array:set(PlacementIdx + R + 1, array:get(PlacementIdx + R + 1, NewAddedPowerDiff1) - Needed, NewAddedPowerDiff1);
                                true ->
                                    NewAddedPowerDiff1
                            end,
                            % Recurse for the next city, updating AddedStationsCount and CurrentAddedPower
                            check_loop(I + 1, N, R, K, TargetMinPower, InitialPowerArray, NewAddedStationsCount, NewAddedPowerDiff, NewCurrentAddedPower + Needed)
                    end;
                true ->
                    % No new station needed for city I, just recurse for the next city
                    check_loop(I + 1, N, R, K, TargetMinPower, InitialPowerArray, AddedStationsCount, AddedPowerDiff, NewCurrentAddedPower)
            end
    end.