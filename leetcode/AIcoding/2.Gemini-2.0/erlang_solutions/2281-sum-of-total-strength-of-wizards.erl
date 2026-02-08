-module(solution).
-export([sum_of_total_strength/1]).

sum_of_total_strength(Strength) ->
  N = length(Strength),
  PrefixSum = prefix_sum(Strength),
  PrefixPrefixSum = prefix_prefix_sum(Strength),
  Mod = 1000000007,
  sum_of_total_strength_helper(Strength, PrefixSum, PrefixPrefixSum, 0, N - 1, Mod).

sum_of_total_strength_helper(_Strength, _PrefixSum, _PrefixPrefixSum, N, N-1, _Mod) -> 0;
sum_of_total_strength_helper(Strength, PrefixSum, PrefixPrefixSum, L, R, Mod) ->
  MinIndex = find_min_index(Strength, L, R),
  MinValue = lists:nth(MinIndex + 1, Strength),
  LeftSum = if MinIndex > L then
              (MinIndex - L) * (prefix_sum_range(PrefixSum, MinIndex, MinIndex, 0) - prefix_sum_range(PrefixPrefixSum, L-1, L-1, 0) + Mod) rem Mod
            else
              0
            end,
  RightSum = if MinIndex < R then
               (R - MinIndex) * (prefix_sum_range(PrefixSum, R, R, 0) - prefix_sum_range(PrefixPrefixSum, MinIndex, MinIndex, 0) + Mod) rem Mod
             else
               0
             end,
  LeftResult = sum_of_total_strength_helper(Strength, PrefixSum, PrefixPrefixSum, L, MinIndex - 1, Mod),
  RightResult = sum_of_total_strength_helper(Strength, PrefixSum, PrefixPrefixSum, MinIndex + 1, R, Mod),
  (((LeftSum + RightSum) rem Mod) * MinValue rem Mod + LeftResult + RightResult) rem Mod.

prefix_sum(Strength) ->
  prefix_sum_helper(Strength, 0, []).

prefix_sum_helper([], Acc, Result) ->
  lists:reverse([Acc | Result]);
prefix_sum_helper([H | T], Acc, Result) ->
  prefix_sum_helper(T, (Acc + H) rem 1000000007, [Acc | Result]).

prefix_prefix_sum(Strength) ->
  PrefixSum = prefix_sum(Strength),
  prefix_prefix_sum_helper(PrefixSum, 0, []).

prefix_prefix_sum_helper([], Acc, Result) ->
  lists:reverse([Acc | Result]);
prefix_prefix_sum_helper([H | T], Acc, Result) ->
  prefix_prefix_sum_helper(T, (Acc + H) rem 1000000007, [Acc | Result]).

prefix_sum_range(PrefixSum, R, R, Acc) ->
  if R < 0 then
    Acc
  else
    (lists:nth(R + 1, PrefixSum) + Acc) rem 1000000007
  end.

find_min_index(Strength, L, R) ->
  find_min_index_helper(Strength, L, R, L, lists:nth(L + 1, Strength), L).

find_min_index_helper(_Strength, _L, R, CurrentIndex, MinValue, MinIndex) when CurrentIndex > R ->
  MinIndex;
find_min_index_helper(Strength, L, R, CurrentIndex, MinValue, MinIndex) ->
  CurrentValue = lists:nth(CurrentIndex + 1, Strength),
  if CurrentValue < MinValue then
    find_min_index_helper(Strength, L, R, CurrentIndex + 1, CurrentValue, CurrentIndex)
  else
    find_min_index_helper(Strength, L, R, CurrentIndex + 1, MinValue, MinIndex)
  end.