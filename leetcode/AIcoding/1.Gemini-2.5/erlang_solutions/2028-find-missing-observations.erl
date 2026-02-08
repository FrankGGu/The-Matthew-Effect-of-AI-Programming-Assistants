-module(solution).
-export([find_missing_observations/3]).

find_missing_observations(Rolls, Mean, N) ->
    SumRolls = lists:sum(Rolls),
    MRolls = length(Rolls),
    TotalObservations = MRolls + N,
    DesiredTotalSum = Mean * TotalObservations,
    TargetSumMissing = DesiredTotalSum - SumRolls,

    MinPossibleSum = N * 1,
    MaxPossibleSum = N * 6,

    if
        TargetSumMissing < MinPossibleSum;
        TargetSumMissing > MaxPossibleSum ->
            []
    else
        BaseVal = TargetSumMissing div N,
        Remainder = TargetSumMissing rem N,
        lists:duplicate(Remainder, BaseVal + 1) ++ lists:duplicate(N - Remainder, BaseVal)
    end.