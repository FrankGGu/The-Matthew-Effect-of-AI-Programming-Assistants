-module(numbers_with_same_consecutive_differences).
-export([numsSameConsecDiff/2]).

numsSameConsecDiff(N, K) ->
  lists:usort([Num || Start <- lists:seq(1, 9), Num <- generate(N - 1, K, Start)]).

generate(0, _, Num) -> [Num];
generate(N, K, Num) ->
  LastDigit = Num rem 10,
  NextDigits = [LastDigit + K, LastDigit - K],
  ValidNextDigits = [D || D <- NextDigits, D >= 0, D <= 9],
  lists:flatten([generate(N - 1, K, Num * 10 + D) || D <- ValidNextDigits]).