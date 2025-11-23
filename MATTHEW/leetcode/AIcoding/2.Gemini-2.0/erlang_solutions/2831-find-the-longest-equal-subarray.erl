-module(longest_equal_subarray).
-export([longest_equal_subarray/2]).

longest_equal_subarray(Nums, K) ->
  longest_equal_subarray(Nums, K, 0, 0, 0, 0, 0, []).

longest_equal_subarray([], _K, MaxLen, _L, _R, _Missing, _Count, _Map) ->
  MaxLen;
longest_equal_subarray([Num | Rest], K, MaxLen, L, R, Missing, Count, Map) ->
  case maps:is_key(Num, Map) of
    true ->
      NewMap = maps:update(Num, maps:get(Num, Map) + 1, Map),
      NewCount = Count + 1,
      longest_equal_subarray(Rest, K, check_and_update(NewCount, R + 1 - L, Missing, K, MaxLen), L, R + 1, Missing, NewCount, NewMap);
    false ->
      NewMap = maps:put(Num, 1, Map),
      NewCount = Count + 1,
      longest_equal_subarray(Rest, K, check_and_update(NewCount, R + 1 - L, Missing, K, MaxLen), L, R + 1, Missing, NewCount, NewMap)
  end.

check_and_update(Count, WindowSize, Missing, K, MaxLen) ->
  NewMissing = Count - WindowSize,
  if NewMissing > K then
    MaxLen
  else
    max(MaxLen, WindowSize)
  end.