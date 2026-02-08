-module(moving_stones).
-export([num_moves_stones/1]).

num_moves_stones(Stones) ->
  Sorted = lists:sort(Stones),
  [A, B, C] = Sorted,
  if C - A == 2 then
    0
  else if B - A <= 2 orelse C - B <= 2 then
    1
  else
    2
  end,
  {min(B - A - 1, C - B - 1), C - A - 2}.