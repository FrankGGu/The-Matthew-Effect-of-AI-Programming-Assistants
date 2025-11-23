-module(solution).
-export([min_travel_time/2]).

min_travel_time(Nums, K) ->
    N = length(Nums),
    Low = lists:max(Nums),
    High = lists:sum(Nums),
    binary_search(Nums, K, N, Low, High, High).

binary_search(Nums, K, N, Low, High, Ans) ->
    if
        Low > High ->
            Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            if
                check(Nums, K, N, Mid) ->
                    binary_search(Nums, K, N, Low, Mid - 1, Mid);
                true ->
                    binary_search(Nums, K, N, Mid + 1, High, Ans)
            end
    end.

check(Nums, K, N, MaxTime) ->
    {FinalSegmentsAcc, _FinalCurrentSum} = lists:foldl(
        fun(Num, {SegmentsAcc, CurrentSumAcc}) ->
            if
                CurrentSumAcc + Num =< MaxTime ->
                    {SegmentsAcc, CurrentSumAcc + Num};
                true ->
                    {SegmentsAcc + 1, Num}
            end
        end,
        {0, 0},
        Nums
    ),
    RequiredSegments = FinalSegmentsAcc + 1,
    MergesAchieved = N - RequiredSegments,
    MergesAchieved >= K.