-module(solution).
-export([pivotIndex/1]).

pivotIndex(Nums) ->
  pivotIndex(Nums, 0, 0, lists:sum(Nums)).

pivotIndex(Nums, Index, LeftSum, TotalSum) ->
  case Index of
    length(Nums) ->
      -1;
    _ ->
      RightSum = TotalSum - LeftSum - lists:nth(Index, Nums);
      if LeftSum =:= RightSum then
        Index
      else
        pivotIndex(Nums, Index + 1, LeftSum + lists:nth(Index, Nums), TotalSum)
      end
  end.