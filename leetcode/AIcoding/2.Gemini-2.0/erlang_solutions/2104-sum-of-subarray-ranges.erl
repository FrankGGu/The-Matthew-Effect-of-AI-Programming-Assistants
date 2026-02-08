-module(subarray_ranges).
-export([subarray_ranges/1]).

subarray_ranges(Nums) ->
  subarray_ranges(Nums, 0).

subarray_ranges(Nums, Acc) ->
  Len = length(Nums),
  subarray_ranges(Nums, Len, 0, Acc).

subarray_ranges(_, 0, _, Acc) ->
  Acc;
subarray_ranges(Nums, Len, I, Acc) ->
  {Min, Max} = min_max_subarray(Nums, I, Len),
  NewAcc = Acc + (Max - Min),
  subarray_ranges(Nums, Len, I + 1, NewAcc).

min_max_subarray(Nums, Start, Len) ->
  min_max_subarray(Nums, Start, Len, lists:nth(Start + 1, Nums), lists:nth(Start + 1, Nums), Start + 1).

min_max_subarray(_, _, Len, Min, Max, Index) when Index > Len ->
  {Min, Max};
min_max_subarray(Nums, Start, Len, Min, Max, Index) ->
  Val = lists:nth(Index + 1, Nums),
  NewMin = min(Min, Val),
  NewMax = max(Max, Val),
  min_max_subarray(Nums, Start, Len, NewMin, NewMax, Index + 1).