-module(valid_parenthesis_string).
-export([check_valid_string/1]).

check_valid_string(S) ->
  check_valid_string(S, 0, 0).

check_valid_string([], Low, High) ->
  Low =< 0 andalso High >= 0.

check_valid_string([C | Rest], Low, High) ->
  case C of
    $( ->
      check_valid_string(Rest, Low + 1, High + 1);
    $) ->
      Low1 = max(0, Low - 1),
      High1 = High - 1,
      High1 >= 0 andalso check_valid_string(Rest, Low1, High1);
    $_ ->
      Low1 = max(0, Low - 1),
      check_valid_string(Rest, Low1, High + 1)
  end.