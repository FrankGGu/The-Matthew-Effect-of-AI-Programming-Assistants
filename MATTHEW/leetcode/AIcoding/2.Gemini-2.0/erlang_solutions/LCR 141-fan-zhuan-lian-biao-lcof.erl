-module(training_plan_iii).
-export([number_of_ways/2]).

number_of_ways(Steps, Arr) ->
  N = length(Arr),
  memo(Steps, 0, N, Arr, []).

memo(0, Index, _, _, _) ->
  case Index of
    0 -> 1;
    _ -> 0
  end;
memo(_, Index, N, _, _) when Index < 0 or Index >= N ->
  0;
memo(Steps, Index, N, Arr, Memo) ->
  case lists:member({Steps, Index}, Memo) of
    true -> 0;
    false ->
      Left = case Index - Arr !! Index >= 0 of
        true -> memo(Steps - 1, Index - Arr !! Index, N, Arr, [{Steps, Index}|Memo]);
        false -> 0
      end,
      Right = case Index + Arr !! Index < N of
        true -> memo(Steps - 1, Index + Arr !! Index, N, Arr, [{Steps, Index}|Memo]);
        false -> 0
      end,
      Left + Right
  end.