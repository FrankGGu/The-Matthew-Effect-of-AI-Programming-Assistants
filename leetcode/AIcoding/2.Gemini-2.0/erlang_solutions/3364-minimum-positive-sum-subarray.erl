-module(minimum_positive_sum_subarray).
-export([min_sub_array_len/2]).

min_sub_array_len(S, Nums) ->
  min_sub_array_len(S, Nums, 0, length(Nums), infinity).

min_sub_array_len(S, Nums, Start, End, MinLen) ->
  case Start >= End of
    true ->
      case MinLen == infinity of
        true -> 0;
        false -> MinLen
      end;
    false ->
      min_sub_array_len(S, Nums, Start, End, min(MinLen, find_min_len(S, Nums, Start, End)))
  end.

find_min_len(S, Nums, Start, End) ->
  find_min_len(S, Nums, Start, End, Start, 0, infinity).

find_min_len(S, Nums, Start, End, Curr, Sum, MinLen) ->
  case Curr >= End of
    true ->
      MinLen;
    false ->
      NewSum = Sum + lists:nth(Curr + 1, Nums),
      case NewSum >= S of
        true ->
          find_min_len(S, Nums, Start, End, Curr + 1, NewSum, min(MinLen, Curr - Start + 1));
        false ->
          find_min_len(S, Nums, Start, End, Curr + 1, NewSum, MinLen)
      end
  end.