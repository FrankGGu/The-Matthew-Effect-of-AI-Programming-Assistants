-module(solution).
-export([isGood/1]).

isGood(Nums) ->
    N = length(Nums),
    if N < 2 ->
        false;
    true ->
        SortedNums = lists:sort(Nums),
        check_sorted(SortedNums, 1, N - 1)
    end.

check_sorted([CurrentExpected | T], CurrentExpected, MaxVal) when CurrentExpected < MaxVal ->
    check_sorted(T, CurrentExpected + 1, MaxVal);
check_sorted([MaxVal, MaxVal], MaxVal, MaxVal) ->
    true;
check_sorted(_, _, _) ->
    false.