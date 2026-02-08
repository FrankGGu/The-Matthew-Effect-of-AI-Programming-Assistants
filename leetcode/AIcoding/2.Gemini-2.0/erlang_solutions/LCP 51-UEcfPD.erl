-module(solution).
-export([max_satisfaction/1]).

max_satisfaction(satisfaction) ->
  lists:reverse(lists:sort(satisfaction, fun(A, B) -> A > B end)),
  max_satisfaction_helper(lists:reverse(lists:sort(satisfaction, fun(A, B) -> A > B end)), 0, 0).

max_satisfaction_helper([], _, Sum) ->
  Sum;
max_satisfaction_helper([H | T], Multiplier, Sum) ->
  NewSum = Sum + (Multiplier + 1) * H,
  case NewSum > Sum of
    true ->
      max_satisfaction_helper(T, Multiplier + 1, NewSum);
    false ->
      Sum
  end.