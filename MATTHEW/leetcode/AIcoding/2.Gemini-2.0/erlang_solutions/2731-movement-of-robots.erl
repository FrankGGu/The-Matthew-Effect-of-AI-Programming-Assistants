-module(movement_of_robots).
-export([sum_distance/2]).

sum_distance(Nums, D) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    NewPositions = [X + D || X <- SortedNums],
    SortedPositions = lists:sort(NewPositions),
    sum_distance_helper(SortedPositions, 0, 0, N, 1000000007).

sum_distance_helper([], _, Sum, _, _) ->
    Sum rem 1000000007;
sum_distance_helper([H|T], PrefixSum, Sum, N, Mod) ->
    NewPrefixSum = (PrefixSum + H) rem Mod,
    Sum1 = (Sum + (H * (lists:len(T) + 1)) rem Mod) rem Mod,
    Sum2 = (Sum1 - PrefixSum + Mod) rem Mod,
    sum_distance_helper(T, NewPrefixSum, Sum2, N, Mod).