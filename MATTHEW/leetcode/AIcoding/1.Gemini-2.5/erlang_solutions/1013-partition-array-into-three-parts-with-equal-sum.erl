-module(solution).
-export([canThreePartsEqualSum/1]).

canThreePartsEqualSum(A) ->
    TotalSum = lists:sum(A),
    if TotalSum rem 3 =/= 0 ->
        false;
    true ->
        TargetSum = TotalSum div 3,
        check(A, TargetSum, 0, 0)
    end.

check([], _TargetSum, _CurrentSum, Count) ->
    Count >= 3.
check([H|T], TargetSum, CurrentSum, Count) ->
    NewCurrentSum = CurrentSum + H,
    if NewCurrentSum == TargetSum ->
        check(T, TargetSum, 0, Count + 1);
    true ->
        check(T, TargetSum, NewCurrentSum, Count)
    end.