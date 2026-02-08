-module(closest_divisors).
-export([closest_divisors/1]).

closest_divisors(Num) ->
  closest_divisors_helper(Num + 1, Num + 2).

closest_divisors_helper(Num1, Num2) ->
  Divisors1 = find_closest_divisors(Num1),
  Divisors2 = find_closest_divisors(Num2),

  Diff1 = abs(Divisors1#pair.a - Divisors1#pair.b),
  Diff2 = abs(Divisors2#pair.a - Divisors2#pair.b),

  if Diff1 < Diff2 then
    [Divisors1#pair.a, Divisors1#pair.b]
  else
    [Divisors2#pair.a, Divisors2#pair.b]
  end.

-record(pair, {a, b}).

find_closest_divisors(Num) ->
  Limit = floor(math:sqrt(Num)),
  find_closest_divisors_helper(Num, Limit, #pair{a = 1, b = Num}).

find_closest_divisors_helper(Num, 0, Pair) ->
  Pair;
find_closest_divisors_helper(Num, I, Pair) ->
  if Num rem I == 0 then
    if abs(I - Num div I) < abs(Pair#a - Pair#b) then
      find_closest_divisors_helper(Num, I - 1, #pair{a = I, b = Num div I})
    else
      find_closest_divisors_helper(Num, I - 1, Pair)
    end
  else
    find_closest_divisors_helper(Num, I - 1, Pair)
  end.