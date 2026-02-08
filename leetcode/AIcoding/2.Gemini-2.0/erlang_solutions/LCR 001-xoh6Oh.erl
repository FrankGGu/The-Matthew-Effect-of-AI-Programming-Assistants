-module(divide).
-export([divide/2]).

divide(Dividend, Divisor) ->
  SignedDividend = Dividend < 0,
  SignedDivisor = Divisor < 0,
  AbsDividend = abs(Dividend),
  AbsDivisor = abs(Divisor),
  Result = divide_abs(AbsDividend, AbsDivisor, 0),
  case {SignedDividend xor SignedDivisor, Result > 2147483647} of
    {true, _} -> -2147483648;
    {false, true} -> 2147483647;
    {true, false} -> -Result;
    {false, false} -> Result
  end.

divide_abs(Dividend, Divisor, Acc) when Dividend < Divisor ->
  Acc;
divide_abs(Dividend, Divisor, Acc) ->
  {Quotient, Remainder} = divide_abs_helper(Dividend, Divisor, 1, Divisor),
  divide_abs(Remainder, Divisor, Acc + Quotient).

divide_abs_helper(Dividend, Divisor, Quotient, CurrentDivisor) when CurrentDivisor > Dividend ->
  {Quotient div 2, Dividend};
divide_abs_helper(Dividend, Divisor, Quotient, CurrentDivisor) ->
  divide_abs_helper(Dividend, Divisor, Quotient * 2, CurrentDivisor * 2).

abs(X) when X >= 0 -> X;
abs(X) -> -X.