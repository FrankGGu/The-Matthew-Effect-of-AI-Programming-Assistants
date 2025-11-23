-module(solution).
-export([maximumSegmentSum/2]).

find(I, ParentArr) ->
    ParentI = array:get(I, ParentArr),
    if
        ParentI == I -> {I, ParentArr};
        true ->
            {Root, NewParentArr} = find(ParentI, ParentArr),
            {Root, array:set(I, Root, NewParentArr)}
    end.

union(I, J, ParentArr, SumArr, CurrentMaxSum) ->
    {RootI, ParentArr1} = find(I, ParentArr),
    {RootJ, ParentArr2} = find(J, ParentArr1),
    if
        RootI == RootJ -> {ParentArr2, SumArr, CurrentMaxSum};
        true ->
            SumI = array:get(RootI, SumArr),
            SumJ = array:get(RootJ, SumArr),
            NewSum = SumI + SumJ,

            ParentArr3 = array:set(RootJ, RootI, ParentArr2),
            SumArr1 = array:set(RootI, NewSum, SumArr),
            NewMaxSum = max(CurrentMaxSum, NewSum),
            {ParentArr3, SumArr1, NewMaxSum}
    end.

maximumSegmentSum(Nums, Removals) ->
    N = length(Nums),
    NumIndices = lists:seq(0, N - 1),
    NumsArr = array:from_list(Nums),

    InitialParentArr = array:from_list(NumIndices),
    InitialSumArr = array:new(N, {default, 0}),
    InitialActiveArr = array:new(N, {default, false}),

    ReversedRemovals = lists:reverse(Removals),

    InitialState = {0, InitialParentArr, InitialSumArr, InitialActiveArr, [], NumsArr},

    {_FinalMaxSum, _FinalParentArr, _FinalSumArr, _FinalActiveArr, FinalResults, _FinalNumsArr} =
        lists:foldl(fun(RemovalIdx, {CurrentMaxSum, ParentArr, SumArr, ActiveArr, AccResults, NumsArrRef}) ->
            NewAccResults = [CurrentMaxSum | AccResults],

            NewActiveArr = array:set(RemovalIdx, true, ActiveArr),
            NumVal = array:get(RemovalIdx, NumsArrRef),

            SumArr1 = array:set(RemovalIdx, NumVal, SumArr),
            CurrentMaxSum1 = max(CurrentMaxSum, NumVal),

            {ParentArr1, SumArr2, CurrentMaxSum2} =
                if
                    RemovalIdx > 0 andalso array:get(RemovalIdx - 1, NewActiveArr) ->
                        union(RemovalIdx, RemovalIdx - 1, ParentArr, SumArr1, CurrentMaxSum1);
                    true ->
                        {ParentArr, SumArr1, CurrentMaxSum1}
                end,

            {ParentArr2, SumArr3, CurrentMaxSum3} =
                if
                    RemovalIdx < N - 1 andalso array:get(RemovalIdx + 1, NewActiveArr) ->
                        union(RemovalIdx, RemovalIdx + 1, ParentArr1, SumArr2, CurrentMaxSum2);
                    true ->
                        {ParentArr1, SumArr2, CurrentMaxSum2}
                end,

            {CurrentMaxSum3, ParentArr2, SumArr3, NewActiveArr, NewAccResults, NumsArrRef}
        end, InitialState, ReversedRemovals),

    FinalResults.