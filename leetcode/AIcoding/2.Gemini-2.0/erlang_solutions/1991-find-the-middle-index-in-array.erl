-module(middle_index).
-export([find_middle_index/1]).

find_middle_index(Nums) ->
  find_middle_index(Nums, 0, lists:sum(Nums), 0).

find_middle_index(_Nums, Index, LeftSum, RightSum) when LeftSum == RightSum ->
  Index;
find_middle_index(Nums, Index, LeftSum, RightSum) when Index >= length(Nums) ->
  -1;
find_middle_index(Nums, Index, LeftSum, RightSum) ->
  find_middle_index(Nums, Index + 1, LeftSum - lists:nth(Index + 1, Nums), RightSum + lists:nth(Index, Nums)).