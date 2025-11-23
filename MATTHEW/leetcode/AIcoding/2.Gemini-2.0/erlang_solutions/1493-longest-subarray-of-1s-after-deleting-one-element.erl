-module(longest_subarray).
-export([longest_subarray/1]).

longest_subarray(Nums) ->
  longest_subarray(Nums, 0, 0, 0, 0).

longest_subarray([], MaxLength, _, _, _) ->
  MaxLength;
longest_subarray([1 | Rest], MaxLength, CurrentLength, ZeroCount, UsedZero) ->
  longest_subarray(Rest, max(MaxLength, CurrentLength + 1), CurrentLength + 1, ZeroCount, UsedZero);
longest_subarray([0 | Rest], MaxLength, CurrentLength, ZeroCount, UsedZero) ->
  if UsedZero == 0 ->
    longest_subarray(Rest, max(MaxLength, CurrentLength), CurrentLength, ZeroCount + 1, 1);
  true ->
    longest_subarray(Rest, max(MaxLength, CurrentLength), 0, ZeroCount + 1, 1)
  end.