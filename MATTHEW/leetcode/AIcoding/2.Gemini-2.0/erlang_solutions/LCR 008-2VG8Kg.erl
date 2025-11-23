-module(minimum_size_subarray_sum).
-export([minSubArrayLen/2]).

minSubArrayLen(Target, Nums) ->
  minSubArrayLen(Target, Nums, 0, 0, 0, infinity).

minSubArrayLen(Target, Nums, Start, End, CurrentSum, MinLen) when End > length(Nums) ->
  case CurrentSum >= Target of
    true ->
      min(MinLen, End - Start);
    false ->
      MinLen
  end;
minSubArrayLen(Target, Nums, Start, End, CurrentSum, MinLen) ->
  case CurrentSum >= Target of
    true ->
      case Start < End of
        true ->
          minSubArrayLen(Target, Nums, Start + 1, End, CurrentSum - lists:nth(Start + 1, Nums), min(MinLen, End - Start));
        false ->
          MinLen
      end;
    false ->
      case End < length(Nums) of
        true ->
          minSubArrayLen(Target, Nums, Start, End + 1, CurrentSum + lists:nth(End + 1, Nums), MinLen);
        false ->
          case CurrentSum >= Target of
            true ->
              min(MinLen, End - Start);
            false ->
              MinLen
          end
      end
  end.