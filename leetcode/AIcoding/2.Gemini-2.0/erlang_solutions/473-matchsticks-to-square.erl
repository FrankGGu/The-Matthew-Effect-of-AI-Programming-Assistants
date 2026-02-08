-module(matchsticks_to_square).
-export([makesquare/1]).

makesquare(Matchsticks) ->
  Len = length(Matchsticks),
  Sum = lists:sum(Matchsticks),
  if Sum rem 4 /= 0 then
    false
  else
    Side = Sum div 4,
    Sorted = lists:sort(Matchsticks, fun(A, B) -> A > B end),
    makesquare_helper(Sorted, Side, 0, 0, 0, 0)
  end.

makesquare_helper([], _, A, B, C, D) ->
  A == 0 and B == 0 and C == 0 and D == 0;
makesquare_helper([H|T], Side, A, B, C, D) ->
  (A >= H and makesquare_helper(T, Side, A - H, B, C, D)) or
  (B >= H and makesquare_helper(T, Side, A, B - H, C, D)) or
  (C >= H and makesquare_helper(T, Side, A, B, C - H, D)) or
  (D >= H and makesquare_helper(T, Side, A, B, C, D - H)).