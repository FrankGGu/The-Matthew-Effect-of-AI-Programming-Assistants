-module(is_good).
-export([is_good/1]).

is_good(Nums) ->
  N = length(Nums),
  Sorted = lists:sort(Nums),
  Expected = lists:seq(1, N - 1) ++ [N, N],
  Sorted =:= Expected.