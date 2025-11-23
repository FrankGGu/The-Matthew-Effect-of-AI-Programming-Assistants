-module(solution).
-export([max_subarray_sum/1]).

max_subarray_sum(Nums) ->
    MaxKadane = kadane(Nums, 0, 0, 0),
    Total = lists:sum(Nums),
    MaxWrap = Total + kadane(lists:map(fun(X) -> -X end, Nums), 0, 0, 0),
    max(MaxKadane, MaxWrap).

kadane([], MaxSoFar, MaxEndingHere, _) -> MaxSoFar;
kadane([H|T], MaxSoFar, MaxEndingHere, Count) ->
    MaxEndingHere1 = max(H, MaxEndingHere + H),
    MaxSoFar1 = max(MaxSoFar, MaxEndingHere1),
    kadane(T, MaxSoFar1, MaxEndingHere1, Count + 1).