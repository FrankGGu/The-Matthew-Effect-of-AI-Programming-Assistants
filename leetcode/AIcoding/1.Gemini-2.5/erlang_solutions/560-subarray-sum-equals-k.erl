-module(solution).
-export([subarraySum/2]).

subarraySum(Nums, K) ->
    subarraySum_acc(Nums, K, 0, #{0 => 1}, 0).

subarraySum_acc([], _K, _CurrentSum, _PrefixSumCounts, Count) ->
    Count;
subarraySum_acc([H|T], K, CurrentSum, PrefixSumCounts, Count) ->
    NewCurrentSum = CurrentSum + H,
    Target = NewCurrentSum - K,

    NewCount = 
        case maps:find(Target, PrefixSumCounts) of
            {ok, Freq} -> Count + Freq;
            error -> Count
        end,

    NewPrefixSumCounts = maps:update_with(NewCurrentSum, fun(OldFreq) -> OldFreq + 1 end, 1, PrefixSumCounts),

    subarraySum_acc(T, K, NewCurrentSum, NewPrefixSumCounts, NewCount).