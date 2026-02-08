-module(permutation).
-export([permute/1]).

permute(Nums) ->
  lists:sort(permute_helper(Nums)).

permute_helper([]) ->
  [[]];
permute_helper(Nums) ->
  lists:foldl(
    fun(Num, Acc) ->
      lists:append(Acc, lists:map(fun(Perm) -> [Num|Perm] end, permute_helper(Nums -- [Num])))
    end,
    [],
    Nums
  ).