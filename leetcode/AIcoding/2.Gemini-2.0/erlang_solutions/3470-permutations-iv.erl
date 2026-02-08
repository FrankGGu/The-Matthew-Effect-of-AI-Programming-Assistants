-module(permutations_iv).
-export([permuteUnique/1]).

permuteUnique(Nums) ->
  UniqueNums = lists:usort(Nums),
  permuteUniqueHelper(UniqueNums, []).

permuteUniqueHelper([], Acc) ->
  [lists:reverse(Acc)];
permuteUniqueHelper(Nums, Acc) ->
  permuteUniqueHelper2(Nums, Acc, []).

permuteUniqueHelper2([], Acc, Result) ->
  Result;
permuteUniqueHelper2(Nums, Acc, Result) ->
  [H|T] = Nums,
  NewNums = lists:delete(H, Nums),
  NewResult = permuteUniqueHelper(NewNums, [H|Acc]),
  permuteUniqueHelper2(T, Acc, Result ++ NewResult).