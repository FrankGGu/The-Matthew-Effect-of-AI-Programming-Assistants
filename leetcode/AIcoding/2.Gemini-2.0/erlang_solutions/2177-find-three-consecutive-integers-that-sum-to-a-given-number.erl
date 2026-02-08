-module(three_consecutive).
-export([sum_of_three/1]).

sum_of_three(Num) ->
  if Num rem 3 == 0 then
    N = Num div 3,
    [N - 1, N, N + 1]
  else
    [].