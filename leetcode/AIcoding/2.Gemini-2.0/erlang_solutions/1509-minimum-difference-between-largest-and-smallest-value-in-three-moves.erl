-module(minimum_difference).
-export([min_difference/1]).

min_difference(Nums) ->
  Len = length(Nums),
  if Len <= 4 then
    0
  else
    Sorted = lists:sort(Nums),
    lists:min([
      lists:nth(Len, Sorted) - lists:nth(4, Sorted),
      lists:nth(Len - 1, Sorted) - lists:nth(3, Sorted),
      lists:nth(Len - 2, Sorted) - lists:nth(2, Sorted),
      lists:nth(Len - 3, Sorted) - lists:nth(1, Sorted)
    ])
  end.