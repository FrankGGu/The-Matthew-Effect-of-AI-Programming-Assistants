-module(find_pivot_index).
-export([pivotIndex/1]).

pivotIndex(Nums) ->
  pivotIndex(Nums, 0, 0, lists:sum(Nums)).

pivotIndex(_Nums, Index, LeftSum, TotalSum) when Index > length(_Nums) - 1 ->
  -1;
pivotIndex(Nums, Index, LeftSum, TotalSum) ->
  RightSum = TotalSum - LeftSum - lists:nth(Index + 1, Nums),
  case LeftSum =:= RightSum of
    true ->
      Index;
    false ->
      pivotIndex(Nums, Index + 1, LeftSum + lists:nth(Index + 1, Nums), TotalSum)
  end.