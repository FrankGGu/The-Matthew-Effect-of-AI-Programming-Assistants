-module(continuous_subarray_sum).
-export([check_subarray_sum/2]).

check_subarray_sum(Nums, K) ->
  check_subarray_sum(Nums, K, 0, #{0 => -1}, 0).

check_subarray_sum([], _K, _Sum, _Map, _Index) ->
  false;
check_subarray_sum([Num | Rest], K, Sum, Map, Index) ->
  NewSum = (Sum + Num) rem K,
  case maps:is_key(NewSum, Map) of
    true ->
      PrevIndex = maps:get(NewSum, Map),
      if Index - PrevIndex > 1 then
        true
      else
        check_subarray_sum(Rest, K, Sum + Num, Map, Index + 1)
      end;
    false ->
      NewMap = maps:put(Map, NewSum, Index),
      check_subarray_sum(Rest, K, Sum + Num, NewMap, Index + 1)
  end.