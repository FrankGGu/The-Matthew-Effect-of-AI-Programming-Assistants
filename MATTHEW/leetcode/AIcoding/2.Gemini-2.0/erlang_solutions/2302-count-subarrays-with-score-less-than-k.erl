-module(solution).
-export([count_subarrays/2]).

count_subarrays(Nums, K) ->
  count_subarrays(Nums, K, 0, 0, 0, 0).

count_subarrays([], _K, _Start, _End, Count, _Sum) ->
  Count;
count_subarrays(Nums, K, Start, End, Count, Sum) ->
  case End < length(Nums) of
    true ->
      NewSum = Sum + lists:nth(End + 1, Nums),
      case NewSum * (End - Start + 1) < K of
        true ->
          count_subarrays(Nums, K, Start, End + 1, Count + (End - Start + 1), NewSum);
        false ->
          case Start < End of
            true ->
              count_subarrays(Nums, K, Start + 1, End, Count, Sum - lists:nth(Start + 1, Nums));
            false ->
              count_subarrays(Nums, K, Start + 1, End + 1, Count, 0)
          end
      end;
    false ->
      Count
  end.