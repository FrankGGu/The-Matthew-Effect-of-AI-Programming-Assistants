-module(closest_subsequence_sum).
-export([minAbsDifference/2]).

minAbsDifference(Nums, Goal) ->
  {Left, Right} = lists:split(length(Nums) div 2, Nums),
  LeftSums = generateSubsequenceSums(Left),
  RightSums = generateSubsequenceSums(Right),
  SortedRightSums = lists:sort(RightSums),
  minAbsDifferenceHelper(LeftSums, SortedRightSums, Goal).

generateSubsequenceSums(Nums) ->
  generateSubsequenceSumsHelper(Nums, 0, []).

generateSubsequenceSumsHelper([], Sum, Acc) ->
  [Sum | Acc];
generateSubsequenceSumsHelper([H | T], Sum, Acc) ->
  generateSubsequenceSumsHelper(T, Sum + H, generateSubsequenceSumsHelper(T, Sum, Acc)).

minAbsDifferenceHelper([], _, _) ->
  infinity;
minAbsDifferenceHelper([LeftSum | Rest], RightSums, Goal) ->
  Target = Goal - LeftSum,
  {ClosestRightSum, _} = findClosest(RightSums, Target, infinity),
  MinAbsDiff = abs(LeftSum + ClosestRightSum - Goal),
  min(MinAbsDiff, minAbsDifferenceHelper(Rest, RightSums, Goal)).

findClosest([H | T], Target, Closest) ->
  case abs(H - Target) < abs(Closest - Target) of
    true -> findClosest(T, Target, H);
    false -> {Closest, T}
  end;
findClosest([], _, Closest) ->
  {Closest, []}.

min(A, B) ->
  if A < B -> A;
     true -> B
  end.

infinity() -> 10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.