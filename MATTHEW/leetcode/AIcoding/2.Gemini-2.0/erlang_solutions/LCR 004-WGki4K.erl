-module(single_number_ii).
-export([singleNumber/1]).

singleNumber(Nums) ->
  singleNumber(Nums, 0, 0).

singleNumber([], A, B) ->
  B;
singleNumber([Num | Rest], A, B) ->
  singleNumber(Rest, (A bxor Num) band (bnot B), (B bxor Num) band (bnot (A bxor Num band (bnot B)))).