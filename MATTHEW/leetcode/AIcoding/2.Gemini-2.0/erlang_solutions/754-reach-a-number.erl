-module(reach_number).
-export([reach_number/1]).

reach_number(Target) ->
  T = abs(Target),
  reach_number_helper(0, 0, T).

reach_number_helper(Step, Sum, Target) ->
  NewSum = Sum + Step + 1,
  if NewSum == Target ->
    Step + 1;
  NewSum > Target ->
    Diff = NewSum - Target,
    if (Diff rem 2) == 0 ->
      Step + 1;
    true ->
      reach_number_helper(Step + 1, NewSum, Target)
    end;
  true ->
    reach_number_helper(Step + 1, NewSum, Target)
  end.