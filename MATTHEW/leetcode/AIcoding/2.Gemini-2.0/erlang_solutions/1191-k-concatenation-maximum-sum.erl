-module(k_concatenation_max_sum).
-export([k_concatenation_max_sum/2]).

k_concatenation_max_sum(Arr, K) ->
  lists:foldl(fun(X, Acc) -> max(0, Acc + X) end, 0, Arr) > 0  andalso  K > 1  ?
    Sum = lists:sum(Arr),
    MaxSubArraySum = max_sub_array_sum(Arr),
    case Sum > 0 of
      true ->
        MaxPrefixSum = max_prefix_sum(Arr),
        MaxSuffixSum = max_suffix_sum(Arr),
        max(MaxSubArraySum, MaxPrefixSum + MaxSuffixSum + (K - 2) * Sum) rem (1000000000 + 7);
      false ->
        MaxSubArraySum rem (1000000000 + 7)
    end;
  max_sub_array_sum(Arr) rem (1000000000 + 7).

max_sub_array_sum(Arr) ->
  max_sub_array_sum_helper(Arr, 0, 0).

max_sub_array_sum_helper([], MaxSoFar, CurrentMax) ->
  max(MaxSoFar, CurrentMax);
max_sub_array_sum_helper([H|T], MaxSoFar, CurrentMax) ->
  NewCurrentMax = max(H, CurrentMax + H),
  NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
  max_sub_array_sum_helper(T, NewMaxSoFar, NewCurrentMax).

max_prefix_sum(Arr) ->
  max_prefix_sum_helper(Arr, 0, 0, 0).

max_prefix_sum_helper([], _, MaxSoFar, _) ->
  MaxSoFar;
max_prefix_sum_helper([H|T], CurrentSum, MaxSoFar, Index) ->
  NewCurrentSum = CurrentSum + H,
  NewMaxSoFar = max(MaxSoFar, NewCurrentSum),
  max_prefix_sum_helper(T, NewCurrentSum, NewMaxSoFar, Index + 1).

max_suffix_sum(Arr) ->
  max_suffix_sum_helper(lists:reverse(Arr), 0, 0, 0).

max_suffix_sum_helper([], _, MaxSoFar, _) ->
  MaxSoFar;
max_suffix_sum_helper([H|T], CurrentSum, MaxSoFar, Index) ->
  NewCurrentSum = CurrentSum + H,
  NewMaxSoFar = max(MaxSoFar, NewCurrentSum),
  max_suffix_sum_helper(T, NewCurrentSum, NewMaxSoFar, Index + 1).

max(A, B) ->
  if A > B -> A;
     true -> B
  end.