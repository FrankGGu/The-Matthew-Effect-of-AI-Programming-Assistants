-module(solution).
-export([maxSumObtained/2]).

maxSumObtained(P, nums) ->
    Sorted = lists:sort(nums),
    Length = length(Sorted),
    max_sum(P, Sorted, Length, 0, 0).

max_sum(_, [], _, Sum, _) -> Sum;
max_sum(P, [H | T], Length, Sum, Index) ->
    NewSum = Sum + H * lists:nth(Index + 1, P),
    max_sum(P, T, Length, NewSum, Index + 1).