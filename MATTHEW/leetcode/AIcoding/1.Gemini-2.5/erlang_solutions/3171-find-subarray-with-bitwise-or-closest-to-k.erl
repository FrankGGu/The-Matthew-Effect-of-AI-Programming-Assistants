-module(solution).
-export([find_subarray_with_bitwise_or_closest_to_k/2]).

find_subarray_with_bitwise_or_closest_to_k(Nums, K) ->
    [FirstNum | RestNums] = Nums,
    InitialMinDiff = abs(FirstNum - K),
    InitialOrsSet = sets:add_element(FirstNum, sets:new()),

    {FinalMinDiff, _} = lists:foldl(
        fun(Num, {AccMinDiff, AccOrsSet}) ->
            NextOrsSet = sets:new(),

            {UpdatedMinDiff1, TempNextOrsSet1} = sets:fold(
                fun(PrevOr, {CurrentMinDiff, CurrentNextOrsSet}) ->
                    NewOr = PrevOr bor Num,
                    Diff = abs(NewOr - K),
                    MinDiffSoFar = min(CurrentMinDiff, Diff),
                    {MinDiffSoFar, sets:add_element(NewOr, CurrentNextOrsSet)}
                end,
                {AccMinDiff, NextOrsSet},
                AccOrsSet
            ),

            DiffNum = abs(Num - K),
            FinalMinDiffForThisIteration = min(UpdatedMinDiff1, DiffNum),
            FinalNextOrsSet = sets:add_element(Num, TempNextOrsSet1),

            {FinalMinDiffForThisIteration, FinalNextOrsSet}
        end,
        {InitialMinDiff, InitialOrsSet},
        RestNums
    ),
    FinalMinDiff.