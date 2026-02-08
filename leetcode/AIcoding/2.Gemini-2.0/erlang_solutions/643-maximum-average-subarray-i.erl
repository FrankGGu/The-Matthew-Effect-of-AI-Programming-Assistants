-module(max_avg_subarray).
-export([find_max_average/2]).

find_max_average(Nums, K) ->
  find_max_average(Nums, K, 0, 0, -100001).

find_max_average([], _, _, _, MaxAvg) ->
  MaxAvg;
find_max_average(Nums, K, Start, CurrentSum, MaxAvg) ->
  case length(Nums) of
    Len when Len < K ->
      MaxAvg;
    _ ->
      case Start + K > length(Nums) of
        true ->
          MaxAvg;
        false ->
          SubArray = lists:sublist(Nums, Start + 1, K),
          Sum = lists:sum(SubArray),
          Avg = Sum / K,
          NewMaxAvg = max(MaxAvg, Avg),
          find_max_average(Nums, K, Start + 1, 0, NewMaxAvg)
      end
  end.

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.