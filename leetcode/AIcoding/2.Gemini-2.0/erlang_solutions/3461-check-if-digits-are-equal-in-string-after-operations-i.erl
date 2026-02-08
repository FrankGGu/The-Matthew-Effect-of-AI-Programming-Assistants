-module(check_equal_digits).
-export([equalDigitFrequency/1]).

equalDigitFrequency(S) ->
  equalDigitFrequency(S, []).

equalDigitFrequency([], Acc) ->
  case Acc of
    [] ->
      true;
    [H|_] ->
      lists:all(fun(X) -> X == H end, Acc);
    _ ->
      false
  end;
equalDigitFrequency([H|T], Acc) ->
  Digit = H - $0,
  equalDigitFrequency(T, lists:keystore(Digit, 1, Acc, {Digit, 1})).