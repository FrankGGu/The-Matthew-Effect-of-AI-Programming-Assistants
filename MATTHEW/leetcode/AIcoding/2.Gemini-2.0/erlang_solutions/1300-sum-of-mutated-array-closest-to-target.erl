-module(find_best_value).
-export([find_best_value/2]).

find_best_value(Arr, Target) ->
  find_best_value(Arr, Target, 0, lists:max(Arr)).

find_best_value(Arr, Target, Low, High) ->
  case Low > High of
    true ->
      V1 = calculate_sum(Arr, Low - 1),
      V2 = calculate_sum(Arr, Low),
      if abs(V1 - Target) =< abs(V2 - Target) then
        Low - 1
      else
        Low
      end;
    false ->
      Mid = (Low + High) div 2,
      Sum = calculate_sum(Arr, Mid),
      case Sum > Target of
        true ->
          find_best_value(Arr, Target, Low, Mid - 1);
        false ->
          find_best_value(Arr, Target, Mid + 1, High)
      end
  end.

calculate_sum(Arr, Value) ->
  lists:sum([min(X, Value) || X <- Arr]).