-module(solution).
-export([purchasePlan/2]).

purchasePlan(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    Array = array:from_list(SortedNums),
    Len = array:size(Array),

    two_pointers(Array, Target, 0, Len - 1, 0).

two_pointers(Array, Target, LeftIdx, RightIdx, Acc) when LeftIdx < RightIdx ->
    LeftVal = array:get(LeftIdx, Array),
    RightVal = array:get(RightIdx, Array),

    if
        LeftVal + RightVal =< Target ->
            NewAcc = Acc + (RightIdx - LeftIdx),
            two_pointers(Array, Target, LeftIdx + 1, RightIdx, NewAcc);
        true ->
            two_pointers(Array, Target, LeftIdx, RightIdx - 1, Acc)
    end;
two_pointers(_Array, _Target, _LeftIdx, _RightIdx, Acc) ->
    Acc.