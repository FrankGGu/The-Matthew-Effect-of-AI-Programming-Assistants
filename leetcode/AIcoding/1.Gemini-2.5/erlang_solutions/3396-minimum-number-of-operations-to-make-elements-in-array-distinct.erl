-module(solution).
-export([minIncrementForUnique/1]).

minIncrementForUnique(Nums) ->
    SortedNums = lists:sort(Nums),
    {TotalOps, _LastVal} = lists:foldl(
        fun(CurrentVal, {OpsAcc, PrevVal}) ->
            if
                CurrentVal <= PrevVal ->
                    NeededVal = PrevVal + 1,
                    NewOpsAcc = OpsAcc + (NeededVal - CurrentVal),
                    {NewOpsAcc, NeededVal};
                true -> % CurrentVal > PrevVal
                    {OpsAcc, CurrentVal}
            end
        end,
        {0, hd(SortedNums)},
        tl(SortedNums)
    ),
    TotalOps.