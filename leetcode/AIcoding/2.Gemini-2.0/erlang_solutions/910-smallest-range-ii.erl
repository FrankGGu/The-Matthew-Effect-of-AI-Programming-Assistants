-module(smallest_range_ii).
-export([smallestRangeII/2]).

smallestRangeII(A, K) ->
  lists:sort(A, fun(X, Y) -> X < Y end) ->
  N = length(A),
  Min = lists:nth(1, A),
  Max = lists:last(A),
  Result = Max - Min,
  lists:foldl(
    fun(I, Acc) ->
      MaxVal = max(lists:nth(I, A) + K, Max - K),
      MinVal = min(Min + K, lists:nth(I + 1, A) - K),
      min(Acc, MaxVal - MinVal)
    end,
    Result,
    lists:seq(1, N - 1)
  ).