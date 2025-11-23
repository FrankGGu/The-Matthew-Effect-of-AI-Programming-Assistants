-module(add_digits).
-export([addDigits/1]).

addDigits(Num) ->
  if Num == 0 then
    0
  else
    (Num - 1) rem 9 + 1
  end.