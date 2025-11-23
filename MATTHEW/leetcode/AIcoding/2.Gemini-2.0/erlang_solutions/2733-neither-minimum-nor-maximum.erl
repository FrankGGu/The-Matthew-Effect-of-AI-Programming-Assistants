-module(solution).
-export([neither_min_max/1]).

neither_min_max(Nums) ->
  case length(Nums) < 3 of
    true -> -1;
    false ->
      [A, B, C] = lists:sublist(Nums, 1, 3),
      Sorted = lists:sort([A, B, C]),
      lists:nth(2, Sorted)
  end.