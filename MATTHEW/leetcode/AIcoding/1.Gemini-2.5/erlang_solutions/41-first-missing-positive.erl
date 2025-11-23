-module(solution).
-export([firstMissingPositive/1]).

firstMissingPositive(Nums) ->
    Len = length(Nums),
    Arr = array:from_list(Nums),
    Arr1 = swap_elements(0, Len, Arr),
    find_missing(0, Len, Arr1).

swap_elements(I, Len, Arr) when I < Len ->
    Val = array:get(I, Arr),
    if
        Val > 0 andalso Val =< Len andalso array:get(Val - 1, Arr) =/= Val ->
            TargetVal = array:get(Val - 1, Arr),
            NewArr = array:set(I, TargetVal, array:set(Val - 1, Val, Arr)),
            swap_elements(I, Len, NewArr);
        true ->
            swap_elements(I + 1, Len, Arr)
    end;
swap_elements(_I, _Len, Arr) ->
    Arr.

find_missing(I, Len, Arr) when I < Len ->
    Val = array:get(I, Arr),
    if
        Val =/= I + 1 ->
            I + 1;
        true ->
            find_missing(I + 1, Len, Arr)
    end;
find_missing(_I, Len, _Arr) ->
    Len + 1.