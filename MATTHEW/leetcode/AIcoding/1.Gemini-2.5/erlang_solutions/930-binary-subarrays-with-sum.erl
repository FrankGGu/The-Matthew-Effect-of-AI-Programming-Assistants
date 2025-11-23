-module(solution).
-export([numSubarraysWithSum/2]).

numSubarraysWithSum(A, Goal) ->
    {_FinalSum, FinalCount, _FinalFreqMap} = lists:foldl(
        fun(X, {CurrentSum, Count, FreqMap}) ->
            NewCurrentSum = CurrentSum + X,
            Target = NewCurrentSum - Goal,
            FoundCount = maps:get(Target, FreqMap, 0),
            NewCount = Count + FoundCount,
            NewFreqMap = maps:update_with(NewCurrentSum, fun(V) -> V + 1 end, 1, FreqMap),
            {NewCurrentSum, NewCount, NewFreqMap}
        end,
        {0, 0, #{0 => 1}},
        A
    ),
    FinalCount.