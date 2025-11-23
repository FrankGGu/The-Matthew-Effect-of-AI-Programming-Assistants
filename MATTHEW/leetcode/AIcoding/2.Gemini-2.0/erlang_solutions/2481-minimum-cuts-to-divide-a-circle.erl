-module(minimum_cuts).
-export([min_cuts/1]).

min_cuts(N) ->
  if N =:= 1 -> 0;
  N rem 2 =:= 0 -> N div 2;
  true -> N
  end.