-module(solution).
-export([count_subarrays/2]).

count_subarrays(Nums, K) ->
  count_subarrays(Nums, K, 0, 0, 0, 0).

count_subarrays([], _K, _Sum, _Count, Result, _Index) ->
  Result;
count_subarrays([H|T], K, Sum, Count, Result, Index) ->
  NewSum = Sum + H,
  NewCount = Count + 1,
  case NewSum * 1.0 / NewCount >= K of
    true ->
      NewResult = Result + length(T) + 1,
      count_subarrays(T, K, 0, 0, NewResult, Index + 1);
    false ->
      count_subarrays(T, K, 0, 0, Result, Index + 1)
  end.