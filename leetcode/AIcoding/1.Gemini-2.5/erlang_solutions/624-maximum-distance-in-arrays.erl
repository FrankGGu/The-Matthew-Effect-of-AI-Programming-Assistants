-module(solution).
-export([maxDistance/1]).

maxDistance(Arrays) ->
    [FirstArray | RestArrays] = Arrays,

    InitialMinVal = hd(FirstArray),
    InitialMaxVal = last(FirstArray),

    % State: {MinValSoFar, MaxValSoFar, MaxDistanceFound}
    % MinValSoFar: The minimum of all 'min' values from arrays processed so far.
    % MaxValSoFar: The maximum of all 'max' values from arrays processed so far.
    % MaxDistanceFound: The maximum distance found between any two numbers from different arrays.
    InitialState = {InitialMinVal, InitialMaxVal, 0},

    {_FinalMinVal, _FinalMaxVal, MaxDist} = lists:foldl(
        fun(CurrentArray, {MinValSoFar, MaxValSoFar, CurrentMaxDist}) ->
            CurrentMin = hd(CurrentArray),
            CurrentMax = last(CurrentArray),

            % Calculate potential new maximum distances using the current array's min/max
            % and the overall min/max found from previously processed arrays.
            % abs(CurrentMax - MinValSoFar): Distance between current array's max and a previous array's min.
            % abs(MaxValSoFar - CurrentMin): Distance between a previous array's max and current array's min.
            Dist1 = abs(CurrentMax - MinValSoFar),
            Dist2 = abs(MaxValSoFar - CurrentMin),

            % Update the overall maximum distance found
            NewMaxDist = max(CurrentMaxDist, max(Dist1, Dist2)),

            % Update the overall minimum and maximum values seen across all arrays processed so far
            NewMinValSoFar = min(MinValSoFar, CurrentMin),
            NewMaxValSoFar = max(MaxValSoFar, CurrentMax),

            {NewMinValSoFar, NewMaxValSoFar, NewMaxDist}
        end,
        InitialState,
        RestArrays
    ),
    MaxDist.