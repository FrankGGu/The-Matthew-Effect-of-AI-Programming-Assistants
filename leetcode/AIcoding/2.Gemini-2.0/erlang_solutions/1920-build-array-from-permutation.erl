-module(solution).
-export([build_array/1]).

build_array(Nums) ->
  [lists:nth(N + 1, Nums) of N <- lists:seq(0, length(Nums) - 1)].