-module(solution).
-export([sum_zero/1]).

sum_zero(N) ->
  case N rem 2 of
    0 ->
      lists:seq(-N div 2, N div 2) -- [0];
    1 ->
      lists:seq(-(N div 2), N div 2)
  end.