-module(factorial_trailing_zeroes).
-export([trailing_zeroes/1]).

trailing_zeroes(N) ->
  trailing_zeroes(N, 0).

trailing_zeroes(0, Acc) ->
  Acc;
trailing_zeroes(N, Acc) ->
  trailing_zeroes(N div 5, Acc + N div 5).