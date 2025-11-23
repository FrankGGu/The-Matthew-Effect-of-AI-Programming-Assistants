-module(alternating_digit_sum).
-export([alternating_digit_sum/1]).

alternating_digit_sum(N) ->
  alternating_digit_sum(integer_to_list(N), 1).

alternating_digit_sum([], Acc) ->
  Acc;
alternating_digit_sum([Digit | Rest], Sign) ->
  NewAcc = (list_to_integer([Digit]) * Sign),
  alternating_digit_sum(Rest, -Sign) + NewAcc.