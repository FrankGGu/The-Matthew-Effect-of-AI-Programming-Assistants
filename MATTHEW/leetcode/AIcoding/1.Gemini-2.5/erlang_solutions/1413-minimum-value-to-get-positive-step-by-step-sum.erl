-module(solution).
-export([min_start_value/1]).
min_start_value(Nums) ->
    {_FinalCurrentPrefixSum, FinalMinPrefixSum} = lists:foldl(
        fun(Num, {CurrentPrefixSum, MinPrefixSum}) ->
            NewCurrentPrefixSum = CurrentPrefixSum + Num,
            NewMinPrefixSum = min(MinPrefixSum, NewCurrentPrefixSum),
            {NewCurrentPrefixSum, NewMinPrefixSum}
        end,
        {0, 0},
        Nums
    ),
    1 - FinalMinPrefixSum.