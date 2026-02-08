-module(count_house_placements).
-export([solve/1]).

solve(N) ->
  F = fun(0) -> 1;
       (1) -> 2;
       (X) -> (F(X-1) + F(X-2)) rem 1000000007
  end,
  F_N = F(N),
  (F_N * F_N) rem 1000000007.