-module(find_missing_observations).
-export([missing_rolls/3]).

missing_rolls(Rolls, Mean, N) ->
  SumRolls = lists:sum(Rolls),
  MissingSum = Mean * (length(Rolls) + N) - SumRolls,
  if MissingSum < N or MissingSum > 6 * N then
    []
  else
    missing_rolls_helper(MissingSum, N, [])
  end.

missing_rolls_helper(0, 0, Acc) ->
  lists:reverse(Acc);
missing_rolls_helper(Sum, N, Acc) when Sum < N or Sum > 6 * N->
  [];
missing_rolls_helper(Sum, N, Acc) ->
  Roll = min(6, Sum - (N - 1)),
  missing_rolls_helper(Sum - Roll, N - 1, [Roll | Acc]).