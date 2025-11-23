-module(shortest_subarray_or_at_least_k).
-export([shortest_subarray/2]).

shortest_subarray(Nums, K) ->
  shortest_subarray_helper(Nums, K, 0, length(Nums) + 1).

shortest_subarray_helper(Nums, K, MinLength, AccLength) ->
  case Nums of
    [] ->
      case AccLength < length(Nums) + 1 andalso AccLength >= 0 of
        true -> AccLength;
        false -> -1
      end;
    _ ->
      shortest_subarray_internal(Nums, K, 1, length(Nums), length(Nums) + 1)
  end.

shortest_subarray_internal(Nums, K, Start, End, MinLength) ->
  case Start > End of
    true ->
      case MinLength < length(Nums) + 1 andalso MinLength >= 0 of
        true -> MinLength;
        false -> -1
      end;
    false ->
      NewMinLength = find_shortest_or_subarray(Nums, K, Start, End, length(Nums) + 1),
      shortest_subarray_internal(Nums, K, Start + 1, End, min(MinLength, NewMinLength))
  end.

find_shortest_or_subarray(Nums, K, Start, End, MinLength) ->
  find_shortest_or_subarray_helper(Nums, K, Start, End, Start, 0, length(Nums) + 1).

find_shortest_or_subarray_helper(Nums, K, Start, End, Current, CurrentOr, MinLength) ->
  case Current > End of
    true ->
      MinLength;
    false ->
      Value = lists:nth(Current, Nums),
      NewOr = CurrentOr bor Value,
      case NewOr >= K of
        true ->
          NewLength = Current - Start + 1,
          find_shortest_or_subarray_helper(Nums, K, Start, End, Current + 1, NewOr, min(MinLength, NewLength));
        false ->
          find_shortest_or_subarray_helper(Nums, K, Start, End, Current + 1, NewOr, MinLength)
      end
  end.