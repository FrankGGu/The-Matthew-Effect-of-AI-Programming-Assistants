-module(atoi).
-export([myAtoi/1]).

myAtoi(Str) ->
  myAtoi(Str, 0, 1).

myAtoi([], Acc, _) ->
  Acc;
myAtoi([H|T], Acc, Sign) when H == $ , ->
  myAtoi(T, Acc, Sign);
myAtoi([H|T], Acc, Sign) when H == $+ ->
  myAtoi(T, Acc, Sign);
myAtoi([H|T], Acc, Sign) when H == $- ->
  myAtoi(T, Acc, -1 * Sign);
myAtoi([H|T], Acc, Sign) when H >= $0, H =< $9 ->
  Digit = H - $0,
  NewAcc = Acc * 10 + Digit,
  case Sign * NewAcc of
    Value when Value > 2147483647 ->
      2147483647;
    Value when Value < -2147483648 ->
      -2147483648;
    _ ->
      myAtoi(T, NewAcc, Sign)
  end;
myAtoi([_|T], Acc, Sign) ->
  Sign * Acc.