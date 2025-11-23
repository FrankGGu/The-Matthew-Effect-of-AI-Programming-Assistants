-module(minimum_size_subarray_sum).
-export([minSubArrayLen/2]).

minSubArrayLen(Target, Nums) ->
  minSubArrayLen(Target, Nums, 0, 0, 0, length(Nums) + 1).

minSubArrayLen(Target, Nums, Start, End, Sum, MinLen) when End == length(Nums) ->
  if
    Sum >= Target ->
      min(MinLen, End - Start);
    true ->
      if
        Start < length(Nums) andalso MinLen == length(Nums) + 1 ->
          0;
        true ->
          MinLen = min(MinLen, length(Nums) + 1),
          case Start < length(Nums) of
            true ->
              minSubArrayLen(Target, Nums, Start + 1, Start + 1, 0, MinLen);
            false ->
              MinLen
          end
      end
  end;

minSubArrayLen(Target, Nums, Start, End, Sum, MinLen) ->
  NewSum = Sum + lists:nth(End + 1, Nums),
  if
    NewSum >= Target ->
      NewMinLen = min(MinLen, End - Start + 1),
      minSubArrayLen(Target, Nums, Start + 1, Start + 1, 0, NewMinLen);
    true ->
      minSubArrayLen(Target, Nums, Start, End + 1, NewSum, MinLen)
  end.