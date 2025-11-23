-module(solution).
-export([number_of_sequences/3]).

number_of_sequences(Differences, Lower, Upper) ->
    F = fun(Diff, {CurrentSum, MinSum, MaxSum}) ->
            NewCurrentSum = CurrentSum + Diff,
            NewMinSum = min(MinSum, NewCurrentSum),
            NewMaxSum = max(MaxSum, NewCurrentSum),
            {NewCurrentSum, NewMinSum, NewMaxSum}
        end,
    {_, MinPrefixSum, MaxPrefixSum} = lists:foldl(F, {0, 0, 0}, Differences),
    LowerBoundX = Lower - MinPrefixSum,
    UpperBoundX = Upper - MaxPrefixSum,
    Result = UpperBoundX - LowerBoundX + 1,
    max(0, Result).