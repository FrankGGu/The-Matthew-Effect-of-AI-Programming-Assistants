-module(make_sum_divisible).
-export([minSubarray/2]).

minSubarray(Nums, P) ->
  N = length(Nums),
  TotalSum = lists:sum(Nums),
  Remainder = TotalSum rem P,
  if Remainder =:= 0 then
    0
  else
    Map = #{0 => -1},
    PrefixSum = 0,
    MinLength = N,
    lists:foreach(fun(I, Num) ->
                  PrefixSum1 = (PrefixSum + Num) rem P,
                  Needed = (PrefixSum1 - Remainder + P) rem P,
                  case maps:is_key(Needed, Map) of
                    true ->
                      PrevIndex = maps:get(Needed, Map),
                      MinLength1 = min(MinLength, I - PrevIndex),
                      Map1 = maps:put(PrefixSum1, I, Map),
                      MinLength2 = MinLength1;
                    false ->
                      Map1 = maps:put(PrefixSum1, I, Map),
                      MinLength2 = MinLength
                  end,
                  MinLength = MinLength2,
                  Map = Map1
                 end, lists:zip(lists:seq(0, N - 1), Nums)),
    if MinLength =:= N then
      -1
    else
      MinLength
    end
  end.