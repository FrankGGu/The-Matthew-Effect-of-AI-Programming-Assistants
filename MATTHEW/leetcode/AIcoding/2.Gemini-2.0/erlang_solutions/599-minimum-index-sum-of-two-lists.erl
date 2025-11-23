-module(minimum_index_sum).
-export([find_restaurant/2]).

find_restaurant(List1, List2) ->
  Map1 = lists:foldl(fun({Elem, Index}, Acc) -> maps:put(Elem, Index, Acc) end, #{}, lists:zip(List1, lists:seq(0, length(List1) - 1))),
  Common = lists:filter(fun(Elem) -> maps:is_key(Elem, Map1) end, List2),
  IndexedCommon = lists:map(fun(Elem) -> {Elem, maps:get(Elem, Map1) + lists:index(List2, Elem) -1 } end, Common),
  MinSum = lists:min([Sum || {_, Sum} <- IndexedCommon]),
  [Elem || {Elem, Sum} <- IndexedCommon, Sum == MinSum].