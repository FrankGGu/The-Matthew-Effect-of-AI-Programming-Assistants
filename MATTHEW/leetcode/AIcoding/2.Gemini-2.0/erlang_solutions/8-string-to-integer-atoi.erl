-module(atoi).
-export([myAtoi/1]).

myAtoi(Str) ->
  Trimmed = string:trim(Str),
  Sign = case Trimmed of
           "+" ++ Rest -> {1, Rest};
           "-" ++ Rest -> {-1, Rest};
           _ -> {1, Trimmed}
         end,
  {S, Rest} = Sign,
  {Result, _} = parse_digits(Rest, 0),
  SignedResult = S * Result,
  case SignedResult of
    R when R > 2147483647 -> 2147483647;
    R when R < -2147483648 -> -2147483648;
    R -> R
  end.

parse_digits(Str, Acc) ->
  case Str of
    [H | T] when H >= $0, H =< $9 ->
      Digit = H - $0,
      NewAcc = Acc * 10 + Digit,
      parse_digits(T, NewAcc);
    _ ->
      {Acc, Str}
  end.