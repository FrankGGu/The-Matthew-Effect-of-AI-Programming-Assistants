-module(perfect_number).
-export([checkPerfectNumber/1]).

checkPerfectNumber(Num) ->
  if Num =< 1 then
    false
  else
    Sum = sum_divisors(Num, 1, 0),
    Sum =:= Num
  end.

sum_divisors(Num, Divisor, Sum) ->
  if Divisor >= Num then
    Sum
  else
    if Num rem Divisor =:= 0 then
      sum_divisors(Num, Divisor + 1, Sum + Divisor)
    else
      sum_divisors(Num, Divisor + 1, Sum)
    end
  end.