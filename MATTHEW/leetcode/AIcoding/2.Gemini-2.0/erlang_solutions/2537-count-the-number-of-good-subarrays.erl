-module(good_subarrays).
-export([count_good_subarrays/1]).

count_good_subarrays(Nums) ->
  count_good_subarrays(Nums, 0, 0, #{0 => 1}).

count_good_subarrays([], _, Count, _) ->
  Count;
count_good_subarrays([Num|Rest], PrefixXor, Count, PrefixMap) ->
  NewPrefixXor = PrefixXor bxor Num,
  NewCount = Count + maps:get(NewPrefixXor, PrefixMap, 0),
  NewPrefixMap = maps:update_with(NewPrefixXor, fun(X) -> X + 1 end, 1, PrefixMap),
  count_good_subarrays(Rest, NewPrefixXor, NewCount, NewPrefixMap).