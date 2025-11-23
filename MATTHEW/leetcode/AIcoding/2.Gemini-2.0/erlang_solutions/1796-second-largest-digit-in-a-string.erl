-module(second_largest_digit).
-export([second_highest/1]).

second_highest(S) ->
  Digits = lists:usort([list_to_integer([C]) || C <- string:to_list(S), C >= '0', C =< '9']),
  case length(Digits) of
    0 -> -1;
    1 -> -1;
    _ -> lists:nth(length(Digits) - 1, Digits)
  end.