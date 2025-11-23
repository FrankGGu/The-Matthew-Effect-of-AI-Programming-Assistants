-module(valid_triangle_number).
-export([triangle_number/1]).

triangle_number(Nums) ->
  SortedNums = lists:sort(Nums),
  Len = length(SortedNums),
  triangle_number_helper(SortedNums, Len - 1, 0).

triangle_number_helper(_Nums, Index, Count) when Index < 2 ->
  Count;
triangle_number_helper(Nums, Index, Count) ->
  Count1 = triangle_number_inner(Nums, Index - 1, 0, Index, Count),
  triangle_number_helper(Nums, Index - 1, Count1).

triangle_number_inner(_Nums, Left, Right, Index, Count) when Left =< Right ->
  Count;
triangle_number_inner(Nums, Left, Right, Index, Count) ->
  if lists:nth(Left, Nums) + lists:nth(Right, Nums) > lists:nth(Index, Nums) ->
    triangle_number_inner(Nums, Left - 1, Right, Index, Count + (Left - Right));
  true ->
    triangle_number_inner(Nums, Left, Right + 1, Index, Count)
  end.