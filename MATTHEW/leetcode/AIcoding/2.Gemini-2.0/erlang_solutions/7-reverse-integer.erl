-module(reverse_integer).
-export([reverse/1]).

reverse(X) ->
  Sign = if X < 0 -> -1; true -> 1 end,
  AbsX = abs(X),
  Reversed = reverse_abs(AbsX, 0),
  Result = Sign * Reversed,
  if Result > 2147483647 orelse Result < -2147483648 ->
    0
  else
    Result
  end.

reverse_abs(0, Acc) ->
  Acc;
reverse_abs(N, Acc) ->
  LastDigit = N rem 10,
  Remaining = N div 10,
  reverse_abs(Remaining, Acc * 10 + LastDigit).