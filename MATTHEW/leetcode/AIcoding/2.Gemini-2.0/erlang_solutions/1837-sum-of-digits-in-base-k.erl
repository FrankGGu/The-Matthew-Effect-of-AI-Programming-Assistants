-module(sum_base).
-export([sum_base/2]).

sum_base(N, K) ->
  sum_digits(N, K, 0).

sum_digits(0, _, Acc) ->
  Acc;
sum_digits(N, K, Acc) ->
  sum_digits(N div K, K, Acc + N rem K).