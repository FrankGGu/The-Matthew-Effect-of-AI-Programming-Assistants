-module(set_mismatch).
-export([find_error_nums/1]).

find_error_nums(Nums) ->
  N = length(Nums),
  Sum = lists:sum(Nums),
  SetSum = lists:sum(lists:seq(1, N)),
  Set = sets:from_list(Nums),
  SetList = sets:to_list(Set),
  SetSumWithoutDup = lists:sum(SetList),
  Repeated = Sum - SetSumWithoutDup,
  Missing = SetSum - SetSumWithoutDup,
  [Repeated, Missing].