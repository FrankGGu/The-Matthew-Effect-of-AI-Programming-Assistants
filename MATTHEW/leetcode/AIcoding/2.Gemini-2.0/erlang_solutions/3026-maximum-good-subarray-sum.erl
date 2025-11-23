-module(maximum_good_subarray_sum).
-export([max_good_subarray_sum/2]).

max_good_subarray_sum(Nums, K) ->
  max_good_subarray_sum(Nums, K, 0, maps:new(), -1000000000000000000).

max_good_subarray_sum([], _K, _CurrentSum, _Seen, MaxSum) ->
  MaxSum;
max_good_subarray_sum([H|T], K, CurrentSum, Seen, MaxSum) ->
  NewCurrentSum = CurrentSum + H,
  Case1 = maps:get(H + K, Seen, 0) > 0,
  Case2 = maps:get(H - K, Seen, 0) > 0,
  NewMaxSum1 = if not (Case1 or Case2) ->
                max(MaxSum, NewCurrentSum);
              true ->
                MaxSum
              end,
  NewSeen = maps:update_with(H, fun(V) -> V + 1 end, 1, Seen),
  max_good_subarray_sum(T, K, NewCurrentSum, NewSeen, NewMaxSum1).