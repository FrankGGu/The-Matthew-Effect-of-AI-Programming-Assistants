-module(solution).
-export([maximum_total_damage/1]).

maximum_total_damage(Damage) ->
    % Max possible damage value from constraints is 10^5.
    % We need an array to store aggregated damage for each spell value.
    % Array indices will be 0 to 100000. Size 100001.
    MaxPossibleDamageVal = 100000,
    InitialPointsArray = array:new([{size, MaxPossibleDamageVal + 1}, {default, 0}]),
    InitialMaxDamageEncountered = 0,

    % First pass: Aggregate damage for each spell value and find the maximum spell value encountered.
    {PointsArray, FinalMaxDamageEncountered} = lists:foldl(
        fun(D, {AccPointsArray, AccMaxDamage}) ->
            CurrentPoints = array:get(D, AccPointsArray),
            NewPoints = CurrentPoints + D,
            NewAccPointsArray = array:set(D, NewPoints, AccPointsArray),
            NewAccMaxDamage = max(AccMaxDamage, D),
            {NewAccPointsArray, NewAccMaxDamage}
        end,
        {InitialPointsArray, InitialMaxDamageEncountered},
        Damage
    ),

    % Dynamic Programming: Calculate maximum total damage.
    % dp[i] represents the maximum damage obtainable considering spells up to value i.
    % dp[i] = max(dp[i-1], dp[i-2] + PointsArray[i])
    % We use space optimization with two variables: prev2 (dp[i-2]) and prev1 (dp[i-1]).
    Prev2 = 0, % Corresponds to dp[i-2]
    Prev1 = 0, % Corresponds to dp[i-1]

    % Iterate from 1 up to FinalMaxDamageEncountered
    % The foldl will return a tuple {Prev2_final, Prev1_final}, where Prev1_final is the result.
    ResultTuple = lists:foldl(
        fun(I, {AccPrev2, AccPrev1}) ->
            CurrentPointsForI = array:get(I, PointsArray),
            CurrentMaxDamage = max(AccPrev1, AccPrev2 + CurrentPointsForI),
            {AccPrev1, CurrentMaxDamage} % Update {Prev2, Prev1} for the next iteration
        end,
        {Prev2, Prev1}, % Initial accumulator {dp[-2], dp[-1]} effectively {0, 0}
        lists:seq(1, FinalMaxDamageEncountered)
    ),

    % The maximum total damage is the second element of the final tuple.
    element(2, ResultTuple).