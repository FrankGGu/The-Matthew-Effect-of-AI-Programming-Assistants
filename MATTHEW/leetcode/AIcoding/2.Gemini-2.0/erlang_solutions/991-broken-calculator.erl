-module(broken_calculator).
-export([broken_calc/2]).

broken_calc(X, Y) ->
  broken_calc_helper(X, Y, 0).

broken_calc_helper(X, Y, Acc) when X >= Y ->
  X - Y + Acc;
broken_calc_helper(X, Y, Acc) when Y rem 2 == 0 ->
  broken_calc_helper(X, Y div 2, Acc + 1);
broken_calc_helper(X, Y, Acc) ->
  broken_calc_helper(X, Y + 1, Acc + 1).