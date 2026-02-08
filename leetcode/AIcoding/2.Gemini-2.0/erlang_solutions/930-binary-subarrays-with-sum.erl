-module(binary_subarrays_with_sum).
-export([num_subarrays_with_sum/2]).

num_subarrays_with_sum(A, Goal) ->
  num_subarrays_with_sum(A, Goal, 0, 0, 0, 0).

num_subarrays_with_sum([], _Goal, Count, _LeadingZeros, _CurrentSum, _Index) ->
  Count;
num_subarrays_with_sum([H|T], Goal, Count, LeadingZeros, CurrentSum, Index) ->
  case H of
    0 ->
      case CurrentSum of
        Goal ->
          num_subarrays_with_sum(T, Goal, Count + LeadingZeros + 1, LeadingZeros + 1, CurrentSum, Index + 1);
        _ ->
          num_subarrays_with_sum(T, Goal, Count, LeadingZeros + 1, CurrentSum, Index + 1)
      end;
    1 ->
      case CurrentSum of
        Goal ->
          num_subarrays_with_sum(T, Goal, Count, 0, CurrentSum + 1, Index + 1);
        _ when CurrentSum < Goal ->
          num_subarrays_with_sum(T, Goal, Count, 0, CurrentSum + 1, Index + 1);
        _ ->
          num_subarrays_with_sum(T, Goal, Count, 0, CurrentSum + 1, Index + 1)
      end
  end.