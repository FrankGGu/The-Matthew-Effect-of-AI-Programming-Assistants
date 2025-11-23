-module(minimum_absolute_sum_difference).
-export([minAbsoluteSumDiff/2]).

minAbsoluteSumDiff(Nums1, Nums2) ->
  Len = length(Nums1),
  SortedNums1 = lists:sort(Nums1),
  minAbsoluteSumDiff(Nums1, Nums2, Len, SortedNums1, 0, 0).

minAbsoluteSumDiff([], [], _, _, Sum, _) ->
  Sum rem 1000000007;
minAbsoluteSumDiff([H1 | T1], [H2 | T2], Len, SortedNums1, Sum, BestReduction) ->
  Diff = abs(H1 - H2),
  MaybeReduction = findClosest(H2, SortedNums1, Len, Diff),
  NewBestReduction = max(BestReduction, MaybeReduction),
  minAbsoluteSumDiff(T1, T2, Len, SortedNums1, Sum + Diff, NewBestReduction).

findClosest(Target, SortedNums1, Len, Diff) ->
  findClosest(Target, SortedNums1, 0, Len - 1, Diff).

findClosest(_, _, Low, High, Diff) when Low > High ->
  Diff;
findClosest(Target, SortedNums1, Low, High, Diff) ->
  Mid = (Low + High) div 2,
  case lists:nth(Mid + 1, SortedNums1) of
    Val when Val == Target ->
      0;
    Val when Val < Target ->
      MaybeReduction = Target - Val,
      if High > Mid then
        findClosest(Target, SortedNums1, Mid + 1, High, Diff)
      else
        MaybeReduction
      end;
    Val ->
      MaybeReduction = Val - Target,
      if Low < Mid then
        findClosest(Target, SortedNums1, Low, Mid - 1, Diff)
      else
        MaybeReduction
      end
  end - Diff.