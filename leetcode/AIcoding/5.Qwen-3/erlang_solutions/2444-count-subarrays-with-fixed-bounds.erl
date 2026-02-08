-module(count_subarrays_with_fixed_bounds).
-export([numSubarrays/2]).

numSubarrays(Nums, K) ->
    Count = fun(Nums, K, 0, 0, 0) -> 
        lists:foldl(fun(N, {MinCount, MaxCount, Result}) ->
            MinCount1 = if N < K -> MinCount + 1; true -> 0 end,
            MaxCount1 = if N > K -> MaxCount + 1; true -> 0 end,
            Result1 = Result + min(MinCount, MaxCount),
            {MinCount1, MaxCount1, Result1}
        end, {0, 0, 0}, Nums)
    end,
    case Count of
        {_, _, R} -> R
    end.