-module(solution).
-export([numberOfSubarrays/2]).

numberOfSubarrays(Nums, K) ->
    {_FinalOddCount, NiceSubarrays, _FinalOddCountsMap} =
        lists:foldl(
            fun(Num, {CurrentOddCount, NiceSubarraysAcc, OddCountsMap}) ->
                NewCurrentOddCount = if
                                         Num rem 2 == 1 -> CurrentOddCount + 1;
                                         true -> CurrentOddCount
                                     end,

                TargetCount = NewCurrentOddCount - K,

                CountOfTarget = maps:get(TargetCount, OddCountsMap, 0),

                NewNiceSubarraysAcc = NiceSubarraysAcc + CountOfTarget,

                NewOddCountsMap = maps:update_with(NewCurrentOddCount, fun(V) -> V + 1 end, 1, OddCountsMap),

                {NewCurrentOddCount, NewNiceSubarraysAcc, NewOddCountsMap}
            end,
            {0, 0, #{0 => 1}},
            Nums
        ),
    NiceSubarrays.