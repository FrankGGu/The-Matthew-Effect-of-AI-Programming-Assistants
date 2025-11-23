-module(solution).
-export([minOperations/1]).

minOperations(Nums) ->
    N = length(Nums),
    UniqueSortedNums = lists:usort(Nums),
    LenUnique = length(UniqueSortedNums),

    IndexedUniqueSortedNums = lists:zip(lists:seq(0, LenUnique - 1), UniqueSortedNums),

    {MinOps, _, _} = lists:foldl(
        fun({LeftIdx, LeftVal}, {AccMinOps, RightIdx, RightList}) ->
            TargetMaxVal = LeftVal + N - 1,

            {NewRightIdx, NewRightList} = move_right_ptr(RightIdx, RightList, TargetMaxVal),

            CountInRange = NewRightIdx - LeftIdx,

            OpsNeeded = N - CountInRange,

            {min(AccMinOps, OpsNeeded), NewRightIdx, NewRightList}
        end,
        {N, 0, UniqueSortedNums},
        IndexedUniqueSortedNums
    ),
    MinOps.

move_right_ptr(CurrentRightIdx, CurrentRightList, TargetMaxVal) ->
    case CurrentRightList of
        [] -> 
            {CurrentRightIdx, []};
        [Head | Tail] when Head =< TargetMaxVal ->
            move_right_ptr(CurrentRightIdx + 1, Tail, TargetMaxVal);
        _ -> 
            {CurrentRightIdx, CurrentRightList}
    end.