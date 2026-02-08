-module(double_reverse).
-export([solve/1]).

solve(Num) ->
  if Num == 0 then
    true
  else
    Rem = Num rem 10,
    Rem /= 0
  end.