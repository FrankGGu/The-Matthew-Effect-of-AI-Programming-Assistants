-module(solution).
-export([split_array/1]).

split_array(Nums) ->
    TotalSum = lists:sum(Nums),
    case TotalSum rem 2 of
        0 ->
            TargetSum = TotalSum div 2,
            check_split(Nums, 0, TargetSum);
        _ ->
            false
    end.

check_split([H|T], CurrentLeftSum, TargetSum) ->
    NewCurrentLeftSum = CurrentLeftSum + H,
    if NewCurrentLeftSum =:= TargetSum andalso T =/= [] ->
        true;
    T =:= [] ->
        false;
    true ->
        check_split(T, NewCurrentLeftSum, TargetSum)
    end;
check_split([], _CurrentLeftSum, _TargetSum) ->
    false.