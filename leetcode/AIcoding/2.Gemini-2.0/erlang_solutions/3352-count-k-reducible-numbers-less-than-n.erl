-module(count_k_reducible).
-export([solve/2]).

solve(N, K) ->
  count_k_reducible(N, K, 1, 0).

count_k_reducible(N, K, Current, Count) ->
  if Current >= N then
    Count
  else
    NewCount =
      case is_k_reducible(Current, K) of
        true -> Count + 1;
        false -> Count
      end,
    count_k_reducible(N, K, Current + 1, NewCount)
  end.

is_k_reducible(N, K) ->
  is_k_reducible(N, K, N).

is_k_reducible(N, K, Original) ->
  if N < K then
    N == 1
  else
    case N rem K of
      0 -> is_k_reducible(N div K, K, Original);
      _ -> N == 1 and Original == 1
    end.